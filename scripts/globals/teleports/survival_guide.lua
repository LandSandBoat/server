-----------------------------------
-- Survival guides global file
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
local survival = require('scripts/globals/teleports/survival_guide_map')
-----------------------------------
xi = xi or {}
xi.survivalGuide = xi.survivalGuide or {}
-----------------------------------

local optionMap =
{
    TELEPORT         = 1,
    UNKNOWN          = 2,
    SET_MENU_LAYOUT  = 3,
    ADD_FAVORITE     = 4,
    REMOVE_FAVORITE  = 5,
    REPLACE_FAVORITE = 6,
    TELEPORT_MENU    = 7,
}

-----------------------------------
-- Local functions
-----------------------------------
local function checkForRegisteredSurvivalGuide(player, guide)
    local hasRegisteredGuide = player:hasTeleport(xi.teleport.type.SURVIVAL, guide.groupIndex - 1, guide.group - 1)

    if not hasRegisteredGuide then
        player:messageSpecial(zones[guide.zoneId].text.COMMON_SENSE_SURVIVAL)
        player:addTeleport(xi.teleport.type.SURVIVAL, guide.groupIndex - 1, guide.group - 1)

        return false
    end

    return true
end

-----------------------------------
-- Public functions
-----------------------------------
xi.survivalGuide.onTrigger = function(player)
    local tableIndex = survival.zoneIdToGuideIdMap[player:getZoneID()]
    local guide      = survival.survivalGuides[tableIndex]

    -- Early return: No info.
    if not guide then
        return
    end

    -- If this survival guide hasn't been registered yet (saved to database) do that now.
    local foundRegisteredGuide = checkForRegisteredSurvivalGuide(player, guide)
    if not foundRegisteredGuide then
        return
    end

    local noTutorialFlag = 0x4000 -- For some reason, this bit is high when you DONT have the tutorial free warp active.
    local tabsCurrency   = bit.lshift(player:getCurrency('valor_point'), 16)
    local param          = bit.bor(tableIndex, tabsCurrency + noTutorialFlag)

    -- Get the teleport menu option.
    -- Menu options can be organized by Region or Content.
    -- Default (0) is region.
    local teleportMenu = player:getTeleportMenu(xi.teleport.type.SURVIVAL)

    -- When all mog tablets are found, survival guides are free.
    local allMogTabletsFound = false -- TODO: Implement mog tablets and fetch if they are all found here.
    if allMogTabletsFound then
        param = bit.bor(param, 0x0400)
    end

    if teleportMenu[10] == 1 then
        param = bit.bor(param, 0x0800)
    end

    -- "Rhapsody in White" key item reduces teleport fee by 80%
    if player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
        param = bit.bor(param, 0x2000)
    end

    -- Tutorial quest special option. Set the bit at 0x4000 to zero.
    if player:getCharVar('TutorialBypass') == 2 then
        param = bit.band(param, bit.bnot(0x4000))
    end

    -- Params 4, 5, 6 and 7
    local g1, g2, g3, g4 = unpack(player:getTeleportTable(xi.teleport.type.SURVIVAL))

    -- Param 8
    local expansions = 3 + 4 * xi.settings.main.ENABLE_COP + 8 * xi.settings.main.ENABLE_TOAU + 16 * xi.settings.main.ENABLE_WOTG + 2048 * xi.settings.main.ENABLE_SOA

    -- param 1 = Does nothing.
    -- param 2 = current area, player amount of tabs, fee reducer(s) and menu layout (region/content).
    -- param 3 = gil
    -- param 4 = zones unlocked (group 1), set to -1 to enable all zones in the group.
    -- param 5 = Zones unlocked (group 2), set to -1 to enable all zones in the group.
    -- param 6 = Zones unlocked (group 3), set to -1 to enable all zones in the group.
    -- param 7 = zones unlocked (Zehrun mines and Eastern Adoulin), set to -1 to enable all zones in the group.
    -- param 8 = expansions available.
    player:startEvent(8500, 0, param, player:getGil(), g1, g2, g3, g4, expansions)
end

xi.survivalGuide.onEventUpdate = function(player, csid, option, npc)
    local choice = bit.band(option, 0xFF)

    if
        choice >= optionMap.SET_MENU_LAYOUT and
        choice <= optionMap.TELEPORT_MENU
    then
        local favorites = player:getTeleportMenu(xi.teleport.type.SURVIVAL)
        local index     = bit.rshift(bit.band(option, 0xFF0000), 16)

        if choice ~= optionMap.TELEPORT_MENU then
            if choice == optionMap.ADD_FAVORITE then
                for x = 1, 9 do
                    local temp = favorites[x]
                    favorites[x] = index
                    index = temp
                end
            elseif choice == optionMap.REMOVE_FAVORITE then
                for x = 1, 9 do
                    if favorites[x] == index then
                        for y = x, 8 do
                            favorites[y] = favorites[y + 1]
                        end

                        favorites[9] = -1
                        break
                    end
                end
            elseif choice == optionMap.REPLACE_FAVORITE then
                favorites[bit.rshift(option, 24) + 1] = index
            elseif choice == optionMap.SET_MENU_LAYOUT then
                favorites[10] = (bit.rshift(option, 16))
            end

            player:setTeleportMenu(xi.teleport.type.SURVIVAL, favorites)
        end

        for x = 1, 3 do
            favorites[1] = favorites[1] + favorites[x + 1] * 256 ^ x
            favorites[5] = favorites[5] + favorites[x + 5] * 256 ^ x
        end

        favorites[9] = favorites[9] + favorites[10] * 256

        player:updateEvent(favorites[1], favorites[5], favorites[9])
    end
end

xi.survivalGuide.onEventFinish = function(player, eventId, option, npc)
    if eventId ~= 8500 then
        return
    end

    if bit.band(option, 0xFF) ~= optionMap.TELEPORT then
        return
    end

    local selectedMenuId = bit.rshift(option, 16)
    if selectedMenuId > 97 then
        return
    end

    -- Early return: No info.
    local guide = survival.survivalGuides[selectedMenuId] -- Destination.
    if not guide then
        return
    end

    -- Early return: Same zone destination as current.
    if guide.zoneId == player:getZoneID() then
        return
    end

    -- Early return: Too far from npc.
    if player:checkDistance(npc) > 6 then
        return
    end

    -- Early return: Doesn't have destination unlocked.
    if not player:hasTeleport(xi.teleport.type.SURVIVAL, guide.groupIndex - 1, guide.group - 1) then
        return
    end

    -- Cost calculations.
    local teleportCostGil  = 1000
    local teleportCostTabs = 50
    local canTeleport      = false

    -- When all mog tablets are found or in the tutorial, survival guides are free.
    local tutorialCostBypass = player:getCharVar('TutorialBypass') == 2
    local allMogTabletsFound = false -- TODO: Implement mog tablets and fetch if they are all found here.

    if allMogTabletsFound then
        teleportCostGil  = 0
        teleportCostTabs = 0

    -- If the player has the "Rhapsody in White" KI, the cost is 1/5 of original gil or 1/5 of original tabs.
    elseif player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
        teleportCostGil  = math.floor(teleportCostGil / 5)
        teleportCostTabs = math.floor(teleportCostTabs / 5)
    end

    -- Payment methods.
    local paymentValor    = bit.band(bit.rshift(option, 8), 1) == 1
    local paymentTutorial = bit.band(bit.rshift(option, 9), 1) == 1

    -- Payment option when selecting "Travel using <amount> tabs." (Valor Points)
    if paymentValor then
        if player:getCurrency('valor_point') >= teleportCostTabs then
            player:delCurrency('valor_point', teleportCostTabs)
            canTeleport = true
        end

    -- Payment option when selecting "One-time free Warp for the objective." (Tutorial option)
    elseif paymentTutorial then
        if tutorialCostBypass then
            player:setCharVar('TutorialBypass', 3)
            canTeleport = true
        end

    -- Payment option when selecting "Travel using <amount> gil." or "Up and away!"
    else
        if player:getGil() >= teleportCostGil then
            player:delGil(teleportCostGil)
            canTeleport = true
        end
    end

    -- Early return: Currency not paid.
    if not canTeleport then
        return
    end

    player:setPos(guide.posX, guide.posY, guide.posZ, guide.posRot, guide.zoneId)
end
