package com.yogurt3d.core.utils
{
	import flash.display.*;
	import flash.display3D.textures.CubeTexture;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.geom.*;

	public class MipmapGenerator
	{
		private static var _matrix : Matrix = new Matrix();
		private static var _rect : Rectangle = new Rectangle();

		public static function generateMipMaps(source : BitmapData, target : CubeTexture, mipmap : BitmapData = null, alpha : Boolean = false) : void
		{
			var w : uint = source.width,
				h : uint = source.height;
			var i : uint;
			var regen : Boolean = mipmap != null;
			mipmap ||= new BitmapData(w, h, alpha);
			
			_matrix.a = 1;
			_matrix.d = 1;
			
			_rect.width = w;
			_rect.height = h;
			
			while (w >= 1 && h >= 1) {
				if (alpha) mipmap.fillRect(_rect, 0);
				mipmap.draw(source, _matrix, null, null, null, true);
				target.uploadFromBitmapData(mipmap, i++);
				w >>= 1;
				h >>= 1;
				_matrix.a *= .5;
				_matrix.d *= .5;
				_rect.width = w;
				_rect.height = h;
			}
			
			if (!regen)
				mipmap.dispose();
		}
		public static function generateMipMapsCube(source : BitmapData, target : CubeTexture, side:uint, mipmap : BitmapData = null, alpha : Boolean = false) : void
		{
			var w : uint = source.width,
				h : uint = source.height;
			var i : uint;
			var regen : Boolean = mipmap != null;
			mipmap ||= new BitmapData(w, h, alpha);
			
			_matrix.a = 1;
			_matrix.d = 1;
			
			_rect.width = w;
			_rect.height = h;
			
			while (w >= 1 && h >= 1) {
				if (alpha) mipmap.fillRect(_rect, 0);
				mipmap.draw(source, _matrix, null, null, null, true);
				target.uploadFromBitmapData(mipmap,side, i++);
				w >>= 1;
				h >>= 1;
				_matrix.a *= .5;
				_matrix.d *= .5;
				_rect.width = w;
				_rect.height = h;
			}
			
			if (!regen)
				mipmap.dispose();
		}
	}
}