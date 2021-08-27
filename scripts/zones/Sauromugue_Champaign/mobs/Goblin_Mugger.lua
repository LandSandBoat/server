-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Goblin Mugger
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 97, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 98, 2, xi.regime.type.FIELDS)

    if xi.settings.ENABLE_ACP == 1 and not player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) and player:getCurrentMission(ACP) >= xi.mission.id.acp.THE_ECHO_AWAKENS then
        -- Guesstimating 15% chance
        if math.random(100) >= 85 then
            player:addKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
        end
    end
end

return entity
