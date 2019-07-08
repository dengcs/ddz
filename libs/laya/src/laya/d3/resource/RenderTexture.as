package laya.d3.resource {
	import laya.layagl.LayaGL;
	import laya.renders.Render;
	import laya.webgl.WebGLContext;
	import laya.resource.BaseTexture;
	import laya.resource.Texture2D;
	
	/**
	   //* <code>RenderTexture</code> 类用于创建渲染目标。
	 */
	public class RenderTexture extends BaseTexture {
		/** @private */
		private static var _temporaryMap:Object = {};
		/** @private */
		private static var _currentActive:RenderTexture;
		
		/**
		 * 获取当前激活的Rendertexture。
		 */
		public static function get currentActive():RenderTexture {
			return _currentActive;
		}
		
		/**
		 * 获取临时渲染目标。
		 */
		public static function getTemporary(width:Number, height:Number, format:int = BaseTexture.FORMAT_R8G8B8, depthStencilFormat:int = BaseTexture.FORMAT_DEPTH_16, filterMode:int = BaseTexture.FILTERMODE_BILINEAR):RenderTexture {
			var key:int = filterMode * 10000000 + depthStencilFormat * 1000000 + format * 100000 + 10000 * height + width;//width和height保留四位
			var textures:Array = _temporaryMap[key];
			if (!textures || textures && textures.length === 0) {
				var renderTexture:RenderTexture = new RenderTexture(width, height, format, depthStencilFormat);
				renderTexture.filterMode = filterMode;
				return renderTexture;
			} else {
				return textures.pop();
			}
		}
		
		/**
		 * 设置释放临时渲染目标,释放后可通过getTemporary复用。
		 */
		public static function setReleaseTemporary(renderTexture:RenderTexture):void {
			var key:int = renderTexture.filterMode * 10000000 + renderTexture.depthStencilFormat * 1000000 + renderTexture.format * 100000 + 10000 * renderTexture.height + renderTexture.width;//width和height保留四位
			var textures:Array = _temporaryMap[key];
			(textures) || (_temporaryMap[key] = textures = []);
			textures.push(renderTexture);
		}
		
		/** @private */
		private var _frameBuffer:*;
		/** @private */
		private var _depthStencilBuffer:*;
		/** @private */
		private var _depthStencilFormat:int;
		
		/**
		 * 获取深度格式。
		 *@return 深度格式。
		 */
		public function get depthStencilFormat():int {
			return _depthStencilFormat;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get defaulteTexture():BaseTexture {
			return Texture2D.grayTexture;
		}
		
		/**
		 * @param width  宽度。
		 * @param height 高度。
		 * @param format 纹理格式。
		 * @param depthStencilFormat 深度格式。
		 * 创建一个 <code>RenderTexture</code> 实例。
		 */
		public function RenderTexture(width:Number, height:Number, format:int = FORMAT_R8G8B8, depthStencilFormat:int = BaseTexture.FORMAT_DEPTH_16) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			super(format, false);
			_glTextureType = WebGLContext.TEXTURE_2D;
			_width = width;
			_height = height;
			_depthStencilFormat = depthStencilFormat;
			_create(width, height);
		}
		
		/**
		 * @private
		 */
		private function _create(width:int, height:int):void {
			var gl:WebGLContext = LayaGL.instance;
			_frameBuffer = gl.createFramebuffer();
			WebGLContext.bindTexture(gl, _glTextureType, _glTexture);
			var glFormat:int = _getGLFormat();
			gl.texImage2D(_glTextureType, 0, glFormat, width, height, 0, glFormat, WebGLContext.UNSIGNED_BYTE, null);
			_setGPUMemory(width * height * 4);
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, _frameBuffer);
			gl.framebufferTexture2D(WebGLContext.FRAMEBUFFER, WebGLContext.COLOR_ATTACHMENT0, WebGLContext.TEXTURE_2D, _glTexture, 0);
			if (_depthStencilFormat !== BaseTexture.FORMAT_DEPTHSTENCIL_NONE) {
				_depthStencilBuffer = gl.createRenderbuffer();
				gl.bindRenderbuffer(WebGLContext.RENDERBUFFER, _depthStencilBuffer);
				switch (_depthStencilFormat) {
				case BaseTexture.FORMAT_DEPTH_16: 
					gl.renderbufferStorage(WebGLContext.RENDERBUFFER, WebGLContext.DEPTH_COMPONENT16, width, height);
					gl.framebufferRenderbuffer(WebGLContext.FRAMEBUFFER, WebGLContext.DEPTH_ATTACHMENT, WebGLContext.RENDERBUFFER, _depthStencilBuffer);
					break;
				case BaseTexture.FORMAT_STENCIL_8: 
					gl.renderbufferStorage(WebGLContext.RENDERBUFFER, WebGLContext.STENCIL_INDEX8, width, height);
					gl.framebufferRenderbuffer(WebGLContext.FRAMEBUFFER, WebGLContext.STENCIL_ATTACHMENT, WebGLContext.RENDERBUFFER, _depthStencilBuffer);
					break;
				case BaseTexture.FORMAT_DEPTHSTENCIL_16_8: 
					gl.renderbufferStorage(WebGLContext.RENDERBUFFER, WebGLContext.DEPTH_STENCIL, width, height);
					gl.framebufferRenderbuffer(WebGLContext.FRAMEBUFFER, WebGLContext.DEPTH_STENCIL_ATTACHMENT, WebGLContext.RENDERBUFFER, _depthStencilBuffer);
					break;
				default: 
					throw "RenderTexture: unkonw depth format.";
				}
			}
			
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, null);
			gl.bindRenderbuffer(WebGLContext.RENDERBUFFER, null);
			
			_setWarpMode(WebGLContext.TEXTURE_WRAP_S, _wrapModeU);
			_setWarpMode(WebGLContext.TEXTURE_WRAP_T, _wrapModeV);
			_setFilterMode(_filterMode);
			_setAnisotropy(_anisoLevel);
			
			_readyed = true;
			_activeResource();
		}
		
		/**
		 * @private
		 */
		public function _start():void {
			LayaGL.instance.bindFramebuffer(WebGLContext.FRAMEBUFFER, _frameBuffer);
			_currentActive = this;
			_readyed = false;
		}
		
		/**
		 * @private
		 */
		public function _end():void {
			LayaGL.instance.bindFramebuffer(WebGLContext.FRAMEBUFFER, null);
			_currentActive = null;
			_readyed = true;
		}
		
		/**
		 * 获得像素数据。
		 * @param x X像素坐标。
		 * @param y Y像素坐标。
		 * @param width 宽度。
		 * @param height 高度。
		 * @return 像素数据。
		 */
		public function getData(x:Number, y:Number, width:Number, height:Number, out:Uint8Array):Uint8Array {//TODO:检查长度
			if (Render.isConchApp && __JS__("conchConfig.threadMode == 2")) {
				throw "native 2 thread mode use getDataAsync";
			}
			var gl:WebGLContext = LayaGL.instance;
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, _frameBuffer);
			var canRead:Boolean = (gl.checkFramebufferStatus(WebGLContext.FRAMEBUFFER) === WebGLContext.FRAMEBUFFER_COMPLETE);
			
			if (!canRead) {
				gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, null);
				return null;
			}
			gl.readPixels(x, y, width, height, WebGLContext.RGBA, WebGLContext.UNSIGNED_BYTE, out);
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, null);
			return out;
		}
		
		/**
		 * native多线程
		 */
		public function getDataAsync(x:Number, y:Number, width:Number, height:Number, callBack:Function):void {
			var gl:* = LayaGL.instance;
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, this._frameBuffer);
			gl.readPixelsAsync(x, y, width, height, WebGLContext.RGBA, WebGLContext.UNSIGNED_BYTE, function(data:ArrayBuffer):void {
				__JS__("callBack(new Uint8Array(data))");
			});
			gl.bindFramebuffer(WebGLContext.FRAMEBUFFER, null);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _disposeResource():void {
			if (_frameBuffer) {
				var gl:WebGLContext = LayaGL.instance;
				gl.deleteTexture(_glTexture);
				gl.deleteFramebuffer(_frameBuffer);
				gl.deleteRenderbuffer(_depthStencilBuffer);
				_glTexture = null;
				_frameBuffer = null;
				_depthStencilBuffer = null;
				_setGPUMemory(0);
			}
		}
	
	}

}
