-- TODO: Headers
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")

local amkHelpers = {}

amkHelpers.helmTrade = function(player, helmType, broke)
    local amkChance = 5
    local regionId = player:getCurrentRegion()

    if
        player:getCurrentMission(AMK) == xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE and
        broke ~= 1
    then
        if
            helmType == xi.helm.type.MINING and
            not player:hasKeyItem(xi.ki.STURDY_METAL_STRIP) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and math.random(100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.STURDY_METAL_STRIP)
        elseif
            helmType == xi.helm.type.LOGGING and
            not player:hasKeyItem(xi.ki.PIECE_OF_RUGGED_TREE_BARK) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and math.random(100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.PIECE_OF_RUGGED_TREE_BARK)
        elseif
            helmType == xi.helm.type.HARVESTING and
            not player:hasKeyItem(xi.ki.SAVORY_LAMB_ROAST) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and math.random(100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.SAVORY_LAMB_ROAST)
        end
    end
end

-- AMK06 and AMK07 - Select/lookup the digging zone
amkHelpers.getDiggingZone = function(player)
    local diggingZone = player:getCharVar("AMK6_DIGGING_ZONE")
    if diggingZone == 0 then
        -- 1 = Valkurm Dunes
        -- 2 = Jugner Forest
        -- 3 = Knoschtat Highlands
        -- 4 = Pashhow Marshlands
        -- 5 = Tahrongi Canyon
        -- 6 = Buburimu Peninsula
        -- 7 = Meriphataud Mountains
        -- 8 = The Sanctuary of Zi'tah
        -- 9 = Yuhtunga Jungle
        -- 10 = Yhoator_Jungle
        -- 11 = Western Altepa Desert
        -- 12 = Eastern Altepa Desert
        diggingZone = math.random(1, 12)
        player:setCharVar("AMK6_DIGGING_ZONE", diggingZone)
    end
    return diggingZone
end

amkHelpers.randomlyPlaceDiggingLocation = function(player)
end

amkHelpers.chocoboDig = function(player, zoneID, ID)
    local playerPos = player:getPos()

    -- Distance between points
    local playerX = playerPos.x
    local playerZ = playerPos.z
    local targetX = 630
    local targetZ = 50
    local distance = math.sqrt(math.pow(targetX - playerX, 2) + math.pow(targetZ - playerZ, 2))

    -- Success!
    if distance < 2.5 then
        npcUtil.giveKeyItem(player, xi.ki.MOLDY_WORMEATEN_CHEST)
        return true
    end

    -- Angle between points
    -- NOTE: ALIGNED TO EAST! DUE EAST = 0
    local theta = math.atan2(playerZ - targetZ, targetX - playerX)
    if theta < 0.0 then theta = theta + math.pi * 2 end
    local angle = theta * (180.0 / math.pi)

    -- Map angle from 0-360 to 0-7 for the messageSpecial arg
    local direction = math.floor(((7 - 0) / (360 - 0)) * (angle - 0))

    -- Your Chocobo is pulling at the bit
    -- You Sense that it is leading you to the [compass direction]
    player:messageSpecial(7318, direction)

    -- No additional hint (Approx: 201'+ from target)
    if distance > 200 then
    -- You have a hunch this area would be favored by moogles... (Approx. 81-200' from target or two map grids)
    elseif distance > 80 then
        player:messageSpecial(7317, direction)
    -- You have a vague feeling that a moogle would enjoy traversing this terrain... (Approx. 51-80' from target)
    elseif distance > 50 then
        player:messageSpecial(7316, direction)
    -- You suspect that the scenery around here would be to a moogle's liking... (Approx. 21-50' from target)
    elseif distance > 20 then
        player:messageSpecial(7315, direction)
    -- You have a feeling your moogle friend has been through this way... (Approx. 11-20' from target)
    elseif distance > 10 then
        player:messageSpecial(7314, direction)
    -- You get the distinct sense that your moogle friend frequents this spot... (Approx. 5-10' from target)
    elseif distance > 5 then
        player:messageSpecial(7313, direction)
    -- You are convinced that your moogle friend has been digging in the immediate vicinity. (Less than 5' from target)
    elseif distance > 2.5 then
        player:messageSpecial(7312, direction)
    end

    return false
end

return amkHelpers
