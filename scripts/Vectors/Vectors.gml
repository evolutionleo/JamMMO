///@function	Vector2(x, y)
///@param		{real} x
///@param		{real} y
function Vector2(_x, _y) constructor {
	if(is_undefined(_x) or is_undefined(_y)) {
		self.zero();
	}
	else {
		x = _x;
		y = _y;
	}
	
	///@function toString()
	function toString() {
		var str = "(x: "+string(self.x)+" y: "+string(self.y)+")";
		return str;
	}
	
	///@function	zero()
	///@description	Nullifies a vector
	zero = function() {
		x = 0;
		y = 0;
		
		return self;
	}
	
	///@function	add(Vec)
	///@description	Adds one vector to another (affecting the first one)
	///@param		{Vector2} Vec
	add = function(_other) {
		x += _other.x;
		y += _other.y;
		
		return self;
	};
	
	///@function	added(Vec)
	///@description	Adds one vector to another an returns the result
	///@param		{Vector2} Vec
	added = function(_other) {
		var temp = new Vector2(x + _other.x, y + _other.y)

		return temp;
	};
	
	///@function	set(Vec)
	///@description	Sets values equal to another vector
	///@param		{Vector2} Vec
	set = function(_other) {
		x = _other.x;
		y = _other.y;
		
		return self;
	};
	
	///@function	multiply(Vec)
	///@description	Multiplies one vector by another
	///@param		{Vector2} Vec
	multiply = function(_other) {
		x *= _other.x;
		y *= _other.y;
		
		return self;
	};
	
	///@function	multiplied(Vec)
	///@description	Multiplies one vector by another an returns the result
	///@param		{Vector2} Vec
	multiplied = function(_other) {
		var temp = new Vector2(x * _other.x, y * _other.y)

		return temp;
	};
	
	///@function	normalize()
	///@description	Normalizes a vector
	normalize = function() {
		var len = self.length();
		
		self.x /= len;
		self.y /= len;
		
		return self;
	}
	
	///@function	normalized()
	///@description	Normalizes a vector
	normalized = function() {
		return self.copy().normalize();
	}
	
	///@function	subtract(Vec)
	///@param		{Vector2} Vec
	subtract = function(_other) {
		x -= _other.x;
		y -= _other.y;
		
		return self;
	}
	
	///@function	clamp(MinVec, MaxVec)
	///@description Clamps the vector within given range
	///@param		{Vector2} MinVec
	///@param		{Vector2} MaxVec
	clamp = function(_min, _max) {
		if(x < _min.x)
			x = _min.x;
		else if(x > _max.x)
			x = _max.x;
		
		if(y < _min.y)
			y = _min.y;
		else if(y > _max.y)
			y = _max.y;
		
		return self;
	};
	
	///@function	map(func)
	///@param		{function} func
	map = function(func) {
		x = func(x);
		y = func(y);
		
		return self;
	}
	
	///@function	hypotenuse()
	hypotenuse = function() {
		return sqrt((x * x) + (y * y));
	}
	
	///@function	length()
	length = function() {
		return self.hypotenuse();
	}
	
	copy = function() {
		return new Vector2(self.x, self.y);
	}
}

// GMLive workaround and a shorter form
function vec2(_x, _y) {
	return new Vector2(_x, _y);
}

function toVector2(val) {
	return new Vector2(val, val);
}