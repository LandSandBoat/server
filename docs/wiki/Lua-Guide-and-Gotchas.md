# Gotchas

### General
We use Sol, which has a Lua 5.3 compatibility layer, on top of luajit 2.0, which acts like Lua 5.1. Given this mismatch there are a few idiosyncracies to be aware of, listed below.

### Lua types and bindings
In order to keep the functionality of the underlying objects (entities, items etc.) separate from the logic in the bindings that are exposed to Lua, the underlying objects are "wrapped" with their Lua bindings type before being sent into Lua function calls. These are also the types that are returned from Lua, so the underlying type has to be extracted.
```cpp
CBaseEntity* PEntity = GetEntity(...); // Underlying Type
CLuaBaseEntity LuaEntity = CLuaBaseEntity(PEntity); // Underlying Type -> Wrapping Type

CLuaBaseEntity ReturnedLuaEntity = luaFunction(LuaEntity); // Return Wrapping Type
CBaseEntity* PReturnedEntity = ReturnedLuaEntity->GetBaseEntity(); // Wrapping Type -> Underlying Type

assert(PEntity == PReturnedEntity);
```

### The Lua stack and va_args
https://sol2.readthedocs.io/en/latest/api/variadic_args.html

In the old style of bindings, we would poke and probe the Lua stack to see what parameters we could pull out of it. This gave us the ability to optionally use different numbers of parameters, or none at all. Sol prioritises safety and correctness, so to support these old function call signatures we have to use `sol::variadic_args`.

We capture these args in the signature like so: `void func(sol::variadic_args va)`

We can ask how many arguments there are: `va.size()`

We can iterate over the arguments: `for (auto& v : va)`

We can index-or-default (0-based): `uint32 x = va[0].is<uint32>() ? va[0].as<uint32>() : 0;`

### Capturing numbers from Lua
From the Lua docs: `The number type represents real (double-precision floating-point) numbers. Lua has no integer type, as it does not need it.`
What this means in practice is if you ask sol "capture this int" or "if this type is an int, ...", it'll fail.

The error message is of the form: `Invalid argument. Expected a number, got a number.`

_When in doubt, capture a double and cast it into whatever you need._

### Global luautils functions

```lua
SpawnMob(...)
DespawnMob(...)
GetPlayerByName(...)
GetPlayerByID(...)
```

### ipairs, pairs, collections
https://sol2.readthedocs.io/en/latest/containers.html
```
Containers from C++ are stored as userdata with special usertype metatables with special operations
...
calling pairs( c ) in Lua 5.1 / LuaJIT will crash with assertion failure (Lua expects c to be a table);
can be used as regular function c:pairs() to get around limitation
```

If returning a container from C++ into Lua, it will be treated as userdata, not a container. You cannot call `pairs(container)`. Instead you must call the convenience function: `container:pairs()`. Same for `ipairs`.

In the interests of keeping the Lua layer consistent, it is preferable to create a table with `auto table = luautils::lua.create_table();`, populate it, and then return that to Lua. This allows you to continue using `pairs(container)`.

**NOTE**: Creating a raw `sol::table` doesn't work. It appears as though the table type is some sort of voodoo with no inherent link to the Lua state, unless you create it that way. Use `lua.create_table()`!

### lua_Number truncation
```cpp
// sol changes this behaviour to return 0 rather than truncating
// we rely on that, so change it back
#undef lua_tointeger
#define lua_tointeger(L, n) static_cast<lua_Integer>(std::floor(lua_tonumber(L, n)))
```
https://github.com/LandSandBoat/server/blob/base/src/map/lua/luautils.h#L37-L40

### Build flags
```cmake
# Globally define SOL_ALL_SAFETIES_ON so sol can be included anywhere
# If SOL_NO_CHECK_NUMBER_PRECISION is defined, turns off number precision and integer
# precision fitting when pushing numbers into sol
# add_compile_definitions() comes with CMake 3.12
add_definitions(-DSOL_ALL_SAFETIES_ON=1 -DSOL_NO_CHECK_NUMBER_PRECISION=1)
```
https://github.com/LandSandBoat/server/blob/base/CMakeLists.txt#L68-L72
