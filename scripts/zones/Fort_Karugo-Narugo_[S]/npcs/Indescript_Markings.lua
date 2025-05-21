-----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -63 -75 4 96
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local loafersQuestProgress = player:getCharVar('AF_SCH_BOOTS')

    player:delStatusEffect(xi.effect.SNEAK)

    -- SCH AF Quest - Boots
    if
        loafersQuestProgress > 0 and
        loafersQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.RAFFLESIA_DREAMSPIT)
    then
        npcUtil.giveKeyItem(player, xi.ki.RAFFLESIA_DREAMSPIT)
        player:setCharVar('AF_SCH_BOOTS', loafersQuestProgress + 1)

        -- Move the markings around
        -- These positions are probably made up
        local positions =
        {
            [1] = { -72.612, -27.5,  671.24 }, -- G-5 NE
            [2] = { -158,    -61.5,  268 },    -- G-7
            [3] = { -2,      -52,    235 },    -- H-8
            [4] = { 224,     -32.25, -22 },    -- I-10
            [5] = { 210,     -42.75, -78 },    -- I-9
            [6] = { -176,    -37,    617 },    -- G-5 SW
            [7] = { 29,      -13.5,  710 },    -- H-5
        }

        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)

        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
        -- player:printToPlayer('Markings moved to position index ' .. newPosition)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
