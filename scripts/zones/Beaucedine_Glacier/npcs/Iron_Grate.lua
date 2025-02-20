-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Iron Grate
-- Type: Door
-- !pos 241.000 5.000 -20.000 111     : J-8
-- !pos 60.000 5.000 -359.000 111     : H-10
-- !pos 100.000 -15.000 159.000 111   : I-7
-- !pos -199.000 -35.000 -220.000 111 : G-9
-- !pos -20.000 -55.000 -41.000 111   : H-8
-- !pos -340.000 -95.000 159.000 111  : F-7
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if xPos < 247 and xPos > 241 then         -- J-8
        player:startEvent(200)
    elseif zPos < -353 and zPos > -359 then  -- H-10
        player:startEvent(201)
    elseif xPos > 95 and xPos < 104 and zPos > 153 and zPos < 159 then    -- I-7
        player:startEvent(202)
    elseif xPos < -193 and xPos > -199 then     -- G-9
        player:startEvent(203)
    elseif zPos > -47 and zPos < -41 then     -- H-8
        player:startEvent(204)
    elseif xPos > -344 and xPos < -337 and zPos > 153 and zPos < 159 then    -- F-7
        player:startEvent(205)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local lvlCap = 0

    if option == 1 then
        if csid == 200 then        -- 50 Cap Area
            lvlCap = 50
            player:setPos(396, -8, -20, 125, 9)
        elseif csid == 201 then -- 60 Cap Area
            lvlCap = 60
            player:setPos(220, -8, -282, 66, 9)
        elseif csid == 202 then -- No Cap Area
            player:setPos(180, -8, 241, 190, 9)
        elseif csid == 203 then -- No Cap Area
            player:setPos(-242, 8, -259, 126, 9)
        elseif csid == 204 then -- Cap 40 Area
            lvlCap = 40
            player:setPos(-180, -8, -78, 194, 9)
        elseif csid == 205 then -- No Cap Area
            player:setPos(-300, -8, 203, 191, 9)
        end

        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
            player:setCharVar('PSOXJA_RESTRICTION_LVL', lvlCap)
        end
    end
end

return entity
