-----------------------------------
-- Area: Leujaoam Sanctum
-- Rune of Release
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance and instance:completed() then
        player:startOptionalCutscene(100, { [0] = 0, cs_option = 0, canSkip = true })
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.runeReleaseFinish(player, csid, option, npc, xi.zone.CAEDARVA_MIRE)
end

return entity
