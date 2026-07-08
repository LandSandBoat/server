-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Starts and Finishes Quest: Tenshodo Membership
-- ENM Quest Activator
-- !pos 16 0 -5 245
-- TODO Enum shop items
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local astralCovenantCD = player:getCharVar('[ENM]AstralCovenant')

    if
        npcUtil.tradeHas(trade, xi.item.FLORID_STONE) and
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD < VanadielTime()
    then
        player:startEvent(10047, 1782)
        player:confirmTrade()
    end
end

--TODO: Need a capture of a player with PSOXJA_PASS and Tenshodo Membership quest avaiable to see how they interact
-- for now, Tenshodo Membership will block ENM.
entity.onTrigger = function(player, npc)
    local astralCovenantCD = player:getCharVar('[ENM]AstralCovenant')

    if
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        not player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
    then
        if astralCovenantCD < VanadielTime() then
            -- Tells player about Florid Stone - option 1 value 4 filters the "hidden" selection for Tenshodo Membership
            player:startEvent(106, 4, 1, xi.item.FLORID_STONE, xi.ki.PSOXJA_PASS, xi.ki.ASTRAL_COVENANT)
        else
            -- Tells player they are on cooldown
            player:startEvent(106, 4, 2, xi.ki.ASTRAL_COVENANT, astralCovenantCD)
        end
    else
        -- Standard interaction
        player:startEvent(106, 4)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 106 and option == 0 then
        local stock =
        {
            { xi.item.RICE_BALL,       168 },
            { xi.item.EEL_KABOB,      3150 },
            { xi.item.GARLIC_CRACKER,    4 },
        }

        xi.shop.general(player, stock, xi.fameArea.NORG)
    elseif csid == 10047 then
        player:setCharVar('[ENM]AstralCovenant', VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        npcUtil.giveKeyItem(player, xi.ki.ASTRAL_COVENANT)
    end
end

return entity
