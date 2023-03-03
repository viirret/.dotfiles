#include <iostream>
#include <vector>

// this is a comment
template<typename T>
struct Vec2
{
	Vec2(T x, T y) : x(x), y(y) {}
	T x;
	T y;

	Vec2 operator+(const Vec2& other) const 
	{
		return Vec2(x + other.x, y + other.y);
	}

	friend std::ostream& operator<<(std::ostream& os, const Vec2& v) 
	{
		os << "(" << v.x << ", " << v.y << ")";
		return os;
	}
};

int main() 
{
    std::vector<Vec2<int>> vec = {{1, 2}, {3, 4}, {-1, 2}};

    for (const auto& v : vec)
	    std::cout << v << std::endl;

    return 0;
}
