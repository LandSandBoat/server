-----------------------------------
-- Area: Mhaura
--  NPC: Wilhelm
-- Type: Standard NPC
-- !pos -22.746 -5 17.157 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

local limbusArmor =
{
    [1920] = {csid = 328, reward = 15241}, -- Ultima's Cerebrum (Nashira Turban)
    [1921] = {csid = 328, reward = 14489}, -- Ultima's Heart    (Nashira Manteel)
    [1922] = {csid = 328, reward = 14906}, -- Ultima's Claw     (Nashira Gages)
    [1923] = {csid = 328, reward = 15577}, -- Ultima's Leg      (Nashira Seraweels)
    [1924] = {csid = 328, reward = 15662}, -- Ultima's Tail     (Nashira Crackows)
    [1925] = {csid = 330, reward = 15240}, -- Omega's Eye       (Homam Zucchetto)
    [1926] = {csid = 330, reward = 14488}, -- Omega's Heart     (Homam Corazza)
    [1927] = {csid = 330, reward = 14905}, -- Omega's Foreleg   (Homam Manopolas)
    [1928] = {csid = 330, reward = 15576}, -- Omega's Hindleg   (Homam Cosciales)
    [1929] = {csid = 330, reward = 15661}, -- Omega's Tail      (Homam Gambieras)
}

function onTrade(player, npc, trade)
    local armor = nil

    for k, v in pairs(limbusArmor) do
        if npcUtil.tradeHasExactly(trade, k) then
            player:setLocalVar("wilhelmTrade", k)
            player:startEvent(v.csid, v.reward)
            break
        end
    end
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) > tpz.mission.id.cop.THE_WARRIOR_S_PATH then
        player:startEvent(326)
    else
        player:startEvent(325)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 328 or csid == 330 then
        -- cheat prevention
        local info = limbusArmor[player:getLocalVar("wilhelmTrade")]
        player:setLocalVar("wilhelmTrade", 0)

        if info and info.csid == csid and info.reward == option and npcUtil.giveItem(player, option) then
            player:confirmTrade()
        end
    end
end
