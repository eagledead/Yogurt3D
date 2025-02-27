/*
 * MaterialEnvMapDiffuseFill.as
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
	import com.yogurt3d.core.materials.shaders.ShaderAmbient;
	import com.yogurt3d.core.materials.shaders.ShaderDiffuse;
	import com.yogurt3d.core.materials.shaders.ShaderEnvMapping;
	import com.yogurt3d.core.materials.shaders.ShaderSolidFill;
	import com.yogurt3d.core.materials.shaders.base.Shader;
	import com.yogurt3d.core.texture.CubeTextureMap;
	import com.yogurt3d.core.texture.TextureMap;
	
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	
	/**
	 * 
 	 * @author Yogurt3D Engine Core Team
 	 * @company Yogurt3D Corp.
	 */
	public class MaterialEnvMapDiffuseFill extends Material
	{
	
		private var m_envMap:CubeTextureMap;
		private var m_normalMap:TextureMap;
		private var m_reflectivityMap:TextureMap;
		private var m_alpha:Number;
		private var m_color:uint;
		
		public  var decal:ShaderSolidFill;
		private var m_envShader:ShaderEnvMapping;
		private var m_ambShader:ShaderAmbient;
		private var m_diffShader:ShaderDiffuse;
		
		public function MaterialEnvMapDiffuseFill( _envMap:CubeTextureMap, 
												   	  _color:uint,
													  _normalMap:TextureMap=null,
													  _reflectivityMap:TextureMap=null,
													  _alpha:Number=1.0,
													  _opacity:Number=1.0,
													  _initInternals:Boolean=true)
		{
			super(_initInternals);
			
			super.opacity = _opacity;
			
			m_envMap = _envMap;		
			m_color  = _color;
			m_normalMap = _normalMap;
			m_reflectivityMap = _reflectivityMap;
			m_alpha = _alpha;
			
			shaders = new Vector.<com.yogurt3d.core.materials.shaders.base.Shader>;
			
			m_envShader = new ShaderEnvMapping(m_envMap, m_normalMap,m_reflectivityMap, m_alpha);
			m_ambShader = new ShaderAmbient(_opacity);
			m_diffShader = new ShaderDiffuse();
			
			decal = new ShaderSolidFill(m_color);
			decal.params.blendEnabled = true;
			decal.params.blendSource = Context3DBlendFactor.DESTINATION_COLOR;
			decal.params.blendDestination = Context3DBlendFactor.ZERO;
			decal.params.depthFunction = Context3DCompareMode.LESS_EQUAL;
			
			shaders.push(m_ambShader);
			shaders.push(m_diffShader);
			shaders.push(decal);
			
			shaders.push(m_envShader);
		}
		
		public function get envMap():CubeTextureMap
		{
			return m_envMap;
		}
		public function set envMap(value:CubeTextureMap):void
		{
			m_envMap = value;
			m_envShader.envMap = value;	
		}
		
		public function get normalMap():TextureMap
		{
			return m_normalMap;
		}
		public function set normalMap(value:TextureMap):void
		{
			m_normalMap = value;
			m_envShader.normalMap = value;
			m_diffShader.normalMap = value;
		}
		
		public function get reflectivityMap():TextureMap
		{
			return m_reflectivityMap;
		}
		public function set reflectivityMap(value:TextureMap):void
		{
			m_reflectivityMap = value;
			m_envShader.reflectivityMap = value;
		}
		
		public function get alpha():Number{
			return m_alpha;
		}
		public function set alpha(_alpha:Number):void{
			m_envShader.alpha = _alpha;
			m_alpha = _alpha;	
		}
		
		public function get color():uint
		{
			return m_color;
		}
		public function set color(value:uint):void
		{
			m_color = value;
			decal.color = value;
		}
		
		public override function set opacity(value:Number):void{
			super.opacity = value;
			m_ambShader.opacity = value;
			decal.opacity = value;
		}	
	}
}