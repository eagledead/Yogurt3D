/*
* MaterialEmptyContour.as
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
	import com.yogurt3d.core.materials.shaders.ShaderContour;
	import com.yogurt3d.core.materials.shaders.base.Shader;
	
	
	public class MaterialEmptyContour extends Material
	{
		private var m_shader:ShaderContour;
		
		public function MaterialEmptyContour(
									 _contourColor:uint = 0x000000,
									 _contourThickness:Number=0.3,
									 _opacity:Number=1.0,_initInternals:Boolean=true)
		{
			super(_initInternals);
			shaders.push( m_shader = new ShaderContour( _contourColor, _contourThickness, _opacity ) );
			
			super.opacity = _opacity;
		}
		
		
		public function get contourThickness():Number{
			return m_shader.contourThickness;
		}
		
		public function set contourThickness(_val:Number):void{
			m_shader.contourThickness = _val;
		}
		
		public function get contourColor():uint{
			return m_shader.contourColor;
		}
		
		public function set contourColor(_val:uint):void{
			m_shader.contourColor = _val;
		}
		
		public override function set opacity( _val:Number ):void{
			super.opacity = _val;
			m_shader.opacity = _val;
		}
	}
}
