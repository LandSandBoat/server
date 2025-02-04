-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Goblin Leecher
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 97, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 98, 2, xi.regime.type.FIELDS)

    if
        xi.settings.main.ENABLE_ACP == 1 and
        not player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) and
        player:getCurrentMission(xi.mission.log_id.ACP) >= xi.mission.id.acp.THE_ECHO_AWAKENS
    then
        -- Guesstimating 15% chance
        if math.random(1, 100) <= 15 then
            npcUtil.giveKeyItem(player, xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
        end
    end
end

return entity
