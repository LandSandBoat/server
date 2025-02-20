-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Indescript Markings
-- NOTE: There are 3 Indescript Markings
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset                = npc:getID() - ID.npc.INDESCRIPT_MARKINGS_OFFSET
    local pantsQuestProgress    = player:getCharVar('AF_SCH_PANTS')
    local gownQuestProgress     = player:getCharVar('AF_SCH_BODY')

    -- SCH AF SIDEQUEST: PANTS
    if
        offset == 1 and
        pantsQuestProgress > 0 and
        pantsQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.SLUG_MUCUS)
    then
        npcUtil.giveKeyItem(player, xi.ki.SLUG_MUCUS)
        player:setCharVar('AF_SCH_PANTS', pantsQuestProgress + 1)

        local positions =
        {
            [1] = {  508, 22, 586 }, -- K-5 N
            [2] = {  543, 22, 478 }, -- K-5 SE
            [3] = {  484, 24, 502 }, -- K-5
            [4] = {  371, 24, 420 }, -- J-6
            [5] = {  226, 25, 316 }, -- I-6
            [6] = {   92, 24, 140 }, -- I-7
            [7] = { -226, 25, 428 }, -- G-6 NW
            [8] = { -135, 24, 374 }, -- G-6 E
        }

        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)
        npc:hideNPC(900)
        npc:setPos(newPosition.x, newPosition.y, newPosition.z)

    -- SCH AF SIDEQUEST: BODY
    elseif
        offset == 2 and
        gownQuestProgress > 0 and
        gownQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.PEISTE_DUNG)
    then
        npcUtil.giveKeyItem(player, xi.ki.PEISTE_DUNG)
        player:setCharVar('AF_SCH_BODY', gownQuestProgress + 1)

        local positions =
        {
            [1] = { 404, 24,   53 },  -- (K-8)
            [2] = { 421, 24, -101 }, -- (K-9)  South of Cavernous Maw
            [3] = { 380, 25, -116 }, -- (J-9)  Just east of the Telepoint.
            [4] = { 411, 25, -292 }, -- (K-10)
            [5] = { 353, 25, -218 }, -- (J-10) Just South from the Veridical Conflux.
            [6] = { 245, 25, -258 }, -- (I-10) On the border between I and J, just south of the road.
            [7] = { -76, 25, -203 }, -- (H-10) NW corner, just south of the road.
            [8] = {  32, 25, -238 }, -- (H-10) North of road. Between road and wall edge.
            [9] = {  59, 25, -326 }, -- (H-10) SE corner, just South of the Road.
        }

        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)
        npc:setPos(newPosition.x, newPosition.y, newPosition.z)

    -- DEFAULT
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
