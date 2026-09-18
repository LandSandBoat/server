/************************************************************************
 * Tester Gear - CPP Module
 *
 * Registers a global Lua function:
 *   addItemToContainer(entity, itemId, locationId [, quantity [, silent]])
 *
 * This allows Lua modules to place items directly into a specific
 * container (inventory, wardrobes, etc.) without modifying base code.
 ************************************************************************/

#include "map/entities/char_entity.h"
#include "map/items/transactions/item_claim.h"
#include "map/lua/lua_base_entity.h"
#include "map/utils/moduleutils.h"

class TesterGearModule : public CPPModule
{
    void OnInit() override
    {
        // Register as a global free function: addItemToContainer(entity, itemId, locationId [, qty [, silent]])
        ::lua.set_function("addItemToContainer", [](CLuaBaseEntity* self, uint16 itemId, uint8 locationId, sol::optional<uint32> qty, sol::optional<bool> silent) -> bool
                           {
                               if (!self || self->GetBaseEntity()->objtype != TYPE_PC)
                               {
                                   ShowWarning("addItemToContainer: called on a non-player entity");
                                   return false;
                               }

                               auto*  PChar    = static_cast<CCharEntity*>(self->GetBaseEntity());
                               uint32 quantity = qty.value_or(1);
                               bool   silence  = silent.value_or(false);

                               auto transaction = ItemClaimTransaction::start(PChar);
                               if (!transaction)
                               {
                                   return false;
                               }

                               return transaction->give(locationId, itemId, quantity, Silence(silence)).has_value() && transaction->commit();
                           });
    }
};

REGISTER_CPP_MODULE(TesterGearModule);
