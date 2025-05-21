-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Saphiriance T.K
-- !pos 113 1 -40 80
-- Retrace NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local allegiance =  player:getCampaignAllegiance()
    local alliedNotes = player:getCurrency('allied_notes')

    if allegiance ~= 0 then
        player:startEvent(454, allegiance, 0, alliedNotes, 0, 0, 0, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 454 then
        player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.RETRACE, 0, 3)
        player:delCurrency('allied_notes', 30)
    end
end

return entity
