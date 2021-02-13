-----------------------------------
-- Area: Rolanberry Fields
--   NM: Chuglix Berrypaws
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if not player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:addKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_CAERULUM)
    end
end

return entity
