/*
 * MaterialBitmap.as
 * This file is part of Yogurt3D Flash Rendering Engine 
 *
 * Copyright (C) 2011 - Yogurt3D Corp.
 *
 * Yogurt3D Flash Rendering Engine is free software; you can redistribute it and/or
 * modify it under the terms of the YOGURT3D CLICK-THROUGH AGREEMENT
 * License.
 * 
 * Yogurt3D Flash Rendering Engine is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
 * 
 * You should have received a copy of the YOGURT3D CLICK-THROUGH AGREEMENT
 * License along with this library. If not, see <http://www.yogurt3d.com/yogurt3d/downloads/yogurt3d-click-through-agreement.html>. 
 */
 
 
package com.yogurt3d.core.materials
{
	import com.yogurt3d.core.materials.base.Material;
	import com.yogurt3d.core.materials.shaders.ShaderTexture;
	import com.yogurt3d.core.texture.TextureMap;
	
	import flash.display.BitmapData;

	/**
	 * Material for backward compability. This material is used for basic texturing, without light of self shadowing.
	 * 
	 * @example Here is a sample usage to assign a texture to a <code>SceneObject</code>.
	 * <listing version="3.0" >
         *   sceneObgject.material = new MaterialBitmap( bitmapdata );
	 * </listing>
 	 * @author Yogurt3D Engine Core Team
 	 * @company Yogurt3D Corp.
 	 **/
	public class MaterialBitmap extends MaterialTexture
	{
		private var decalShader:ShaderTexture;
		/**
		 *  Constructor
		 * @param _bitmapData Texture
		 * @param _miplevel 
		 * @param _initInternals
		 * 
		 */
		public function MaterialBitmap(_texture:BitmapData, _miplevel:uint=0, _initInternals:Boolean=true)
		{
			super( new TextureMap(_texture), _miplevel, _initInternals);
		}
	}
}
