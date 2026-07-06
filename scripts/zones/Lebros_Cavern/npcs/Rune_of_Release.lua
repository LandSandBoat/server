-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance and instance:completed() then
        player:startOptionalCutscene(100, { [0] = 2, cs_option = 0, canSkip = true })
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.MOUNT_ZHAYOLM)
    xi.assault.runeReleaseFinish(player, csid, option, npc)
end

return entity
