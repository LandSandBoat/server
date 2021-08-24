-----------------------------------
-- Area: Port Jeuno
--  NPC: Horst
-- Type: Abyssea Warp NPC
-- !pos -54.379 0.001 -10.061 246
-----------------------------------
local entity = {}

local teleportData =
{
    { -562,   0,  640,  26, 102 }, -- La Theine Plateau
    {   91, -68, -582, 237, 108 }, -- Konschtat Highlands
    {  -28,  46, -680,  76, 117 }, -- Tahrongi Canyon
    {  241,   0,   11,  42, 104 }, -- Jugner Forest (Vunkerl)
    {  362,   0, -119,   4, 103 }, -- Valkurm Dunes (Misareaux)
    { -338, -23,   47, 167, 118 }, -- Buburimu Peninsula (Attohwa)
    {  337,   0, -675,  52, 107 }, -- South Gustaberg (Altepa)
    {  269,  -7,  -75, 192, 112 }, -- Xarcabard (Uleguerand)
    {  -71,   0,  601, 126, 106 }, -- North Gustaberg (Grauberg)
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local totalCruor = player:getCurrency("cruor")
    local unlockedMaws = player:getUnlockedMawTable()
    local statusParam = player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS)

    player:startEvent(339, statusParam, totalCruor, unlockedMaws[1], unlockedMaws[2], unlockedMaws[3])
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local teleportSelection = bit.band(bit.rshift(option, 2), 0xF)

    -- Bit 8 is set for all teleport selections
    if
        utils.mask.getBit(option, 8) and
        player:getCurrency("cruor") >= 200
    then
        player:delCurrency("cruor", 200)
        player:setPos(unpack(teleportData[teleportSelection]))
    end
end

return entity
