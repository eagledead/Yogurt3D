/*
 * MaterialEnvMapDiffuseTexture.as
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
	import com.yogurt3d.core.materials.shaders.ShaderTexture;
	import com.yogurt3d.core.materials.shaders.base.Shader;
	import com.yogurt3d.core.texture.CubeTextureMap;
	import com.yogurt3d.core.texture.TextureMap;
	
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	
	/**
	 * 
	 * @author Yogurt3D Corp. Core Team
	 *  
	 */
	public class MaterialEnvMapDiffuseTexture extends Material
	{
		private var m_envMap:CubeTextureMap;
		private var m_colorMap:TextureMap;
		private var m_normalMap:TextureMap;
		private var m_alpha:Number;
		private var m_reflectivityMap:TextureMap;
		public  var m_decalShader:ShaderTexture;

		private var m_envShader:ShaderEnvMapping;
		private var m_ambShader:ShaderAmbient;
		private var m_diffShader:ShaderDiffuse;
		
		public function MaterialEnvMapDiffuseTexture( _envMap:CubeTextureMap, 
									    _colorMap:TextureMap,
									    _normalMap:TextureMap=null,
										_reflectivityMap:TextureMap=null,
									    _alpha:Number=1.0,
										_opacity:Number=1.0,
									    _initInternals:Boolean=true)
		{
			super(_initInternals);
			
			super.opacity = _opacity;
			
			m_envMap = _envMap;		
			m_colorMap = _colorMap;
			m_normalMap = _normalMap;
			m_alpha = _alpha;
			m_reflectivityMap = _reflectivityMap;
			
			m_envShader = new ShaderEnvMapping(m_envMap, m_normalMap, m_reflectivityMap, m_alpha);
			m_ambShader = new ShaderAmbient();
			m_ambShader.opacity = _opacity;
			m_diffShader = new ShaderDiffuse();
			
			shaders = new Vector.<com.yogurt3d.core.materials.shaders.base.Shader>;
			
			shaders.push(m_ambShader);
			shaders.push(m_diffShader);
			
			
			m_decalShader = new ShaderTexture(m_colorMap);
			m_decalShader.params.blendEnabled = true;
			m_decalShader.params.blendSource = Context3DBlendFactor.DESTINATION_COLOR;
			m_decalShader.params.blendDestination = Context3DBlendFactor.ZERO;
			m_decalShader.params.depthFunction = Context3DCompareMode.EQUAL;
			shaders.push(m_decalShader);
		
			shaders.push(m_envShader);
		}
		
		public override function set opacity(_value:Number):void{
			m_ambShader.opacity = _value;
		
		}
		
		
		public function get envMap():CubeTextureMap
		{
			return m_envMap;
		}
		
		public function set envMap(value:CubeTextureMap):void{
			m_envMap = value;
			m_envShader.envMap = value;
		}
		
		public function get texture():TextureMap{
			return m_colorMap;	
		}
		
		public function set texture(value:TextureMap):void
		{
			m_colorMap = value;
			if( value )
			{
				if( m_decalShader )
				{
					m_decalShader.texture = value;
				}else{
					m_decalShader = new ShaderTexture(m_colorMap);
					m_decalShader.params.blendEnabled = true;
					m_decalShader.params.blendSource = Context3DBlendFactor.DESTINATION_COLOR;
					m_decalShader.params.blendDestination = Context3DBlendFactor.ZERO;
					m_decalShader.params.depthFunction = Context3DCompareMode.EQUAL;
					shaders.splice(2,0,m_decalShader);
				}
			}else{
				if( m_decalShader )
				{
					shaders.splice(shaders.indexOf(m_decalShader),1);
					m_decalShader.dispose();
					m_decalShader = null;
				}
			}
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
		
		public function get alpha():Number{
			return m_alpha;	
		}
		public function set alpha(_value:Number):void{
			m_envShader.alpha = _value;
			m_alpha = _value;
		}
		
		public function get reflectivityMap():TextureMap
		{
			return m_reflectivityMap;
		}
		
		
		public function set reflectivityMap(_value:TextureMap):void
		{
			m_reflectivityMap = _value;
			m_envShader.reflectivityMap = _value;
		}
		
	}
}