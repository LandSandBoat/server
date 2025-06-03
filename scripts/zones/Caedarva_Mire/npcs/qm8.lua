-----------------------------------
-- Area: Caedarva Mire
--  NPC: qm8
-- Gives Lamian Fang Key
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('[TIMER]Lamian_Fang_Key') ~= VanadielUniqueDay() then
        if npcUtil.giveItem(player, xi.item.LAMIAN_FANG_KEY) then
            player:setCharVar('[TIMER]Lamian_Fang_Key', VanadielUniqueDay()) -- Can obtain key once per vanadiel day
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
