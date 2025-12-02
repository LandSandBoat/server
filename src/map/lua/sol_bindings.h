/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include "sol/sol.hpp"

// sol changes this behavior to return 0 rather than truncating
// we rely on that, so change it back
// clang-format off
#undef lua_tointeger
#define lua_tointeger(L, n) static_cast<lua_Integer>(std::floor(lua_tonumber(L, n)))

#define SOL_USERTYPE(TypeName, BindingTypeName) \
    std::string className   = TypeName;         \
    auto        typeBuilder = lua.new_usertype<BindingTypeName>(className)

#define SOL_USERTYPE_INHERIT(TypeName, BindingTypeName, ...)                         \
    std::string className   = TypeName;                                              \
    auto        typeBuilder = lua.new_usertype<BindingTypeName>(className,           \
                                                                sol::no_constructor, \
                                                                sol::base_classes, sol::bases<__VA_ARGS__>())

#define SOL_REGISTER(FuncName, Func) lua[className][FuncName] = &Func

#define SOL_READONLY(PropName, Func) typeBuilder[PropName] = sol::readonly_property(&Func)

#define SOL_BIND_DEC(LuaType, CppType) \
    int sol_lua_push(sol::types<CppType*>, lua_State* L, CppType* obj);

#define SOL_BIND_DEC_SUB(LuaType, BaseCppType, CppType) \
    int sol_lua_push(sol::types<CppType*>, lua_State* L, CppType* obj);

#define SOL_BIND_DEF(LuaType, CppType)                                                      \
    int sol_lua_push(sol::types<CppType*>, lua_State* L, CppType* obj)                      \
    {                                                                                       \
        return obj ? sol::stack::push<LuaType>(L, obj) : sol::stack::push(L, sol::lua_nil); \
    }

#define SOL_BIND_DEF_SUB(LuaType, BaseCppType, CppType)                                                   \
    int sol_lua_push(sol::types<CppType*>, lua_State* L, CppType* obj)                                    \
    {                                                                                                     \
        return obj ? sol::stack::push<LuaType>(L, (BaseCppType*)obj) : sol::stack::push(L, sol::lua_nil); \
    }
// clang-format on

//
// Class bindings
//

class CAbility;
class CLuaAbility;
SOL_BIND_DEC(CLuaAbility, CAbility);

class CLuaAction;
struct action_t;
SOL_BIND_DEC(CLuaAction, action_t);

class CLuaAttack;
class CAttack;
SOL_BIND_DEC(CLuaAttack, CAttack);

class CLuaBaseEntity;
class CBaseEntity;
SOL_BIND_DEC(CLuaBaseEntity, CBaseEntity);

class CBattleEntity;
class CNpcEntity;
class CCharEntity;
class CMobEntity;
class CAutomatonEntity;
class CFellowEntity;
class CPetEntity;
class CTrustEntity;
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CBattleEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CNpcEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CCharEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CMobEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CAutomatonEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CFellowEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CPetEntity);
SOL_BIND_DEC_SUB(CLuaBaseEntity, CBaseEntity, CTrustEntity);

class CLuaBattlefield;
class CBattlefield;
SOL_BIND_DEC(CLuaBattlefield, CBattlefield);

class CLuaInstance;
class CInstance;
SOL_BIND_DEC(CLuaInstance, CInstance);

class CLuaItem;
class CItem;
SOL_BIND_DEC(CLuaItem, CItem);

class CItemCurrency;
class CItemEquipment;
class CItemFish;
class CItemFlowerpot;
class CItemFurnishing;
class CItemGeneral;
class CItemLinkshell;
class CItemPuppet;
class CItemShop;
class CItemUsable;
class CItemWeapon;
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemCurrency);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemEquipment);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemFish);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemFlowerpot);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemFurnishing);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemGeneral);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemLinkshell);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemPuppet);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemShop);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemUsable);
SOL_BIND_DEC_SUB(CLuaItem, CItem, CItemWeapon);

class CLuaLootContainer;
struct LootContainer;
SOL_BIND_DEC(CLuaLootContainer, LootContainer);

class CLuaMobSkill;
class CMobSkill;
SOL_BIND_DEC(CLuaMobSkill, CMobSkill);

class CLuaPetSkill;
class CPetSkill;
SOL_BIND_DEC(CLuaPetSkill, CPetSkill);

class CLuaSpell;
class CSpell;
SOL_BIND_DEC(CLuaSpell, CSpell);

class CLuaStatusEffect;
class CStatusEffect;
SOL_BIND_DEC(CLuaStatusEffect, CStatusEffect);

class CLuaTradeContainer;
class CTradeContainer;
SOL_BIND_DEC(CLuaTradeContainer, CTradeContainer);

class CLuaTriggerArea;
class ITriggerArea;
SOL_BIND_DEC(CLuaTriggerArea, ITriggerArea);

class CLuaZone;
class CZone;
SOL_BIND_DEC(CLuaZone, CZone);

class CLuaTreasurePool;
class CTreasurePool;
SOL_BIND_DEC(CLuaTreasurePool, CTreasurePool);
