-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Goblin Mugger
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 86, 2, tpz.regime.type.FIELDS)

    if ENABLE_ACP == 1 and player:getCurrentMission(ACP) >= tpz.mission.id.acp.THE_ECHO_AWAKENS and not player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) then
        -- Guesstimating 15% chance
        if math.random(100) <= 15 then
            player:addKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
        end
    end
end

return entity
