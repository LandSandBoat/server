-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rytaal
-- !pos 112.002 -1.338 -45.038 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local currentAssault = player:getCurrentAssault()

    if
        player:getCurrentMission(xi.mission.log_id.TOAU) <= xi.mission.id.toau.IMMORTAL_SENTRIES or
        player:getMainLvl() <= 49
    then
        player:startEvent(270)
    elseif currentAssault ~= 0 and player:getCharVar('assaultEntered') ~= 0 then
        if player:getCharVar('AssaultComplete') == 1 then
            player:messageText(player, ID.text.ASSAULT_COMPLETE)
            player:completeAssault(currentAssault)
        elseif currentAssault == 51 then
            player:messageText(player, ID.text.NYZUL_FAIL)
            player:delAssault(currentAssault)
        else
            player:addAssaultPoint(xi.assault.getAssaultArea(player), 100)
            player:messageText(player, ID.text.ASSAULT_FAILED)
            player:delAssault(currentAssault)
        end

        player:setCharVar('AssaultComplete', 0)
        player:setCharVar('assaultEntered', 0)
        player:setCharVar('Assault_Armband', 0)

        for _, orders in pairs(xi.assault.assaultOrders) do
            if player:hasKeyItem(orders) then
                player:delKeyItem(orders)
            end
        end

        for maps = xi.ki.MAP_OF_LEUJAOAM_SANCTUM, xi.ki.MAP_OF_NYZUL_ISLE do
            if player:hasKeyItem(maps) then
                player:delKeyItem(maps)
            end
        end
    elseif
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.PRESIDENT_SALAHEEM or
        (player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.PRESIDENT_SALAHEEM and
        player:getCharVar('ToAU3Progress') >= 1)
    then
        local currentTime = os.time()
        local refreshTime = player:getCharVar('nextTagTime')
        local idTagPeriod = 86400

        if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
            idTagPeriod = 600
        end

        local diffPeriod =  math.floor((currentTime - refreshTime) / idTagPeriod)
        local tagStock = player:getCurrency('id_tags')
        local allTagsTimeCS = (refreshTime - 1009897200) + (diffPeriod * idTagPeriod)
        local haveimperialIDtag = 0
        local tagsAvail = 0

        while currentTime >= refreshTime and tagStock < 3 do
            refreshTime = refreshTime + idTagPeriod
            tagStock = tagStock + 1
        end

        player:setCurrency('id_tags', tagStock)
        player:setCharVar('nextTagTime', refreshTime)

        if player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) then
            haveimperialIDtag = 1
        end

        if tagStock > 0 then
            tagsAvail = 1
        end

        player:startEvent(268, 2, tagStock, currentAssault, haveimperialIDtag, allTagsTimeCS, tagsAvail)
    else
        -- Something went worng, clear all data
        player:setCharVar('AssaultComplete', 0)
        player:setCharVar('assaultEntered', 0)
        player:setCharVar('Assault_Armband', 0)
        player:delAssault(currentAssault)
        for _, orders in pairs(xi.assault.assaultOrders) do
            if player:hasKeyItem(orders) then
                player:delKeyItem(orders)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local tagStock = player:getCurrency('id_tags')

    if
        csid == 268 and
        option == 1 and
        not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and
        tagStock > 0
    then
        if player:getCurrentAssault() ~= 0 then
            player:messageSpecial(ID.text.CANNOT_ISSUE_TAG, xi.ki.IMPERIAL_ARMY_ID_TAG)
            return
        end

        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)

        local idTagPeriod = 86400

        if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
            idTagPeriod = 600
        end

        if tagStock >= 3 then
            player:setCharVar('nextTagTime', os.time() + idTagPeriod)
        end

        player:setCurrency('id_tags', tagStock - 1)
    elseif
        csid == 268 and
        option == 2 and
        xi.assault.hasOrders(player) and
        not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
    then
        local currentAssault = player:getCurrentAssault()

        for _, orders in pairs(xi.assault.assaultOrders) do
            if player:hasKeyItem(orders) then
                player:delKeyItem(orders)
            end
        end

        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)
        player:delAssault(currentAssault)
    end
end

return entity
