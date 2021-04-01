-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Goblin Digger
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 86, 2, xi.regime.type.FIELDS)

    if ENABLE_ACP == 1 and player:getCurrentMission(ACP) >= xi.mission.id.acp.THE_ECHO_AWAKENS and not player:hasKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE) then
        -- Guesstimating 15% chance
        if math.random(100) <= 15 then
            player:addKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
        end
    end
end

return entity
