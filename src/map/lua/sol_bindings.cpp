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

#include "sol_bindings.h"

// clang-format off
#include "ability.h"
#include "lua_ability.h"
SOL_BIND_DEF(CLuaAbility, CAbility);

#include "action/action.h"
#include "lua_action.h"
SOL_BIND_DEF(CLuaAction, action_t);

#include "attackround.h"
#include "lua_attack.h"
SOL_BIND_DEF(CLuaAttack, CAttack);

#include "entities/baseentity.h"
#include "lua_baseentity.h"
SOL_BIND_DEF(CLuaBaseEntity, CBaseEntity);

#include "entities/automatonentity.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/fellowentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"
#include "entities/trustentity.h"
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CBattleEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CNpcEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CCharEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CMobEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CAutomatonEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CFellowEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CPetEntity);
SOL_BIND_DEF_SUB(CLuaBaseEntity, CBaseEntity, CTrustEntity);

#include "battlefield.h"
#include "lua_battlefield.h"
SOL_BIND_DEF(CLuaBattlefield, CBattlefield);

#include "instance.h"
#include "lua_instance.h"
SOL_BIND_DEF(CLuaInstance, CInstance);

#include "items/item.h"
#include "lua_item.h"
SOL_BIND_DEF(CLuaItem, CItem);

#include "items/item_currency.h"
#include "items/item_equipment.h"
#include "items/item_fish.h"
#include "items/item_flowerpot.h"
#include "items/item_furnishing.h"
#include "items/item_general.h"
#include "items/item_linkshell.h"
#include "items/item_puppet.h"
#include "items/item_shop.h"
#include "items/item_usable.h"
#include "items/item_weapon.h"
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemCurrency);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemEquipment);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemFish);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemFlowerpot);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemFurnishing);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemGeneral);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemLinkshell);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemPuppet);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemShop);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemUsable);
SOL_BIND_DEF_SUB(CLuaItem, CItem, CItemWeapon);

#include "utils/itemutils.h"
#include "lua_loot.h"
SOL_BIND_DEF(CLuaLootContainer, LootContainer);

#include "mobskill.h"
#include "lua_mobskill.h"
SOL_BIND_DEF(CLuaMobSkill, CMobSkill);

#include "petskill.h"
#include "lua_petskill.h"
SOL_BIND_DEF(CLuaPetSkill, CPetSkill);

#include "spell.h"
#include "lua_spell.h"
SOL_BIND_DEF(CLuaSpell, CSpell);

#include "status_effect.h"
#include "lua_statuseffect.h"
SOL_BIND_DEF(CLuaStatusEffect, CStatusEffect);

#include "trade_container.h"
#include "lua_trade_container.h"
SOL_BIND_DEF(CLuaTradeContainer, CTradeContainer);

#include "trigger_area.h"
#include "lua_trigger_area.h"
SOL_BIND_DEF(CLuaTriggerArea, ITriggerArea);

#include "zone.h"
#include "lua_zone.h"
SOL_BIND_DEF(CLuaZone, CZone);

#include "treasure_pool.h"
#include "lua_treasure_pool.h"
SOL_BIND_DEF(CLuaTreasurePool, CTreasurePool);
// clang-format on
