/*
 * MouseEvent3D.as
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
package com.yogurt3d.core.events {
	import com.yogurt3d.core.sceneobjects.interfaces.ISceneObject;
	import com.yogurt3d.core.sceneobjects.interfaces.ISceneObjectRenderable;
	
	import flash.events.Event;
	import flash.geom.Vector3D;

	/**
	  * 
	  * 
 	  * @author Yogurt3D Engine Core Team
 	  * @company Yogurt3D Corp.
 	  **/
	public class MouseEvent3D extends Event 
	{
		public static var MOUSE_UP		: String = "mouseUp";
		public static var MOUSE_DOWN	: String = "mouseDown";
		public static var MOUSE_MOVE	: String = "mouseMove";
		public static var MOUSE_OVER	: String = "mouseOver";
		public static var MOUSE_OUT		: String = "mouseOut";
		public static var CLICK			: String = "click";
		public static var DOUBLE_CLICK	: String = "doucleClick";
		
		private var m_intersection 		: Vector3D;
		
		/**
		 * Triangle index which mouse is interacting
		 */
		public var triangle		 		: int;
		/**
		 * Texture U coordinate which mouse is interacting
		 */
		public var u					: Number;
		/**
		 * Texture V coordinate which mouse is interacting
		 */
		public var v					: Number;		
		
		public var target3d				: ISceneObjectRenderable;
		
		public var currentTarget3d		: ISceneObject;
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function MouseEvent3D(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		

		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */
		public override function clone():Event 
		{ 
			var _event:MouseEvent3D = new MouseEvent3D(type, bubbles, cancelable);
			_event.m_intersection 	= m_intersection;
			_event.triangle 		= triangle;
			_event.u 				= u;
			_event.v				= v;
			_event.target3d 		= target3d;
			_event.currentTarget3d 	= currentTarget3d;
			
			return _event;
		} 
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */
		public override function toString():String 
		{ 
			return formatToString("MouseEvent3D", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/**
		 * 3D coordinate of the mouse
		 * @return 
		 * 
		 */
		public function get intersection():Vector3D {
			return m_intersection;
			
		}
		
		/**
		 * @private 
		 */
		public function set intersection(value:Vector3D):void
		{
			m_intersection = value;
		}
		public function get intersectionGlobal():Vector3D{
			return target3d.transformation.matrixGlobal.transformVector( m_intersection );	
		}
		/**
		 * 3D coordinate of the mouse
		 * @return 
		 * 
		 */
		public function get normal():Vector3D {
			
			
			return null;
			
		}
		
		
	}
}

