-----------------------------------
-- Area: Rolanberry Fields
--   NM: Chuglix Berrypaws
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        not player:hasKeyItem(xi.ki.SEEDSPALL_CAERULUM) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        player:addKeyItem(xi.ki.SEEDSPALL_CAERULUM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_CAERULUM)
    end
end

return entity
