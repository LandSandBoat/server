-----------------------------------
-- Seekers of Adoulin Helpers
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.soa = xi.soa or {}
xi.soa.helpers = xi.soa.helpers or {}

xi.soa.helpers.imprimaturGate = function(player, gateAmount)
    -- TODO: All of this
    local imprimatursSpent = 0 -- TODO: Pull from DB
    local fame = player:getFameLevel(xi.quest.fame_area.ADOULIN)
    local gate = 100 - (fame * gateAmount)
    return imprimatursSpent >= gate
end
