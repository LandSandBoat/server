-----------------------------------
-- Area: Batallia Downs
--  Mob: Goblin Pathfinder
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Batallia_Downs/IDs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 2, tpz.regime.type.FIELDS)
    if (ENABLE_ACP == 1 and (player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) == false) and player:getCurrentMission(ACP) >= tpz.mission.id.acp.THE_ECHO_AWAKENS) then
        -- Guesstimating 15% chance
        if (math.random(1, 100) >= 85) then
            player:addKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
        end
    end

end
