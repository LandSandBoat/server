-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Goblin Smithy
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 97, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 98, 2, tpz.regime.type.FIELDS)

    if ENABLE_ACP == 1 and not player:hasKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) and player:getCurrentMission(ACP) >= tpz.mission.id.acp.THE_ECHO_AWAKENS then
        -- Guesstimating 15% chance
        if math.random(100) >= 85 then
            player:addKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
        end
    end
end

return entity
