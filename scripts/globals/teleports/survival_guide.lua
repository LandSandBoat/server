-----------------------------------
-- Survival guides global file
-----------------------------------
require('scripts/globals/teleports')
require('scripts/globals/utils')
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
    TELEPORT_MENU    = 7
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
    local currentZoneId = player:getZoneID()
    local tableIndex    = survival.zoneIdToGuideIdMap[currentZoneId]
    local guide         = survival.survivalGuides[tableIndex]
    local expansions    = 3 + (4 * xi.settings.main.ENABLE_COP) + (8 * xi.settings.main.ENABLE_TOAU) + (16 * xi.settings.main.ENABLE_WOTG) + (2048 * xi.settings.main.ENABLE_SOA)

    if guide then
        -- If this survival guide hasn't been registered yet (saved to database) do that now.
        local foundRegisteredGuide = checkForRegisteredSurvivalGuide(player, guide)

        if foundRegisteredGuide then
            local param = bit.bor(tableIndex, bit.lshift(player:getCurrency('valor_point'), 16))

            -- Get the teleport menu option.
            -- Menu options can be organized by Region or Content.
            -- Default (0) is region.
            local teleportMenu = player:getTeleportMenu(xi.teleport.type.SURVIVAL)

            if teleportMenu[10] == 1 then
                param = bit.bor(param, 0x0800)
            end

            if player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
                -- "Rhapsody in White" key item reduces teleport fee by 80%
                param = bit.bor(param, 0x2000)
            end

            local g1, g2, g3, g4 = unpack(player:getTeleportTable(xi.teleport.type.SURVIVAL))

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
    else
        player:printToPlayer('Survival guides are not enabled!')
    end
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
                favorites[10] = (bit.rshift(option, 16) and 1) or 0
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
    if
        eventId == 8500 and
        bit.band(option, 0xFF) == optionMap.TELEPORT
    then
        local selectedMenuId = bit.rshift(option, 16)

        if selectedMenuId <= 97 then
            local guide         = survival.survivalGuides[selectedMenuId] -- Destination.
            local currentZoneId = player:getZoneID()

            if
                guide and
                guide.zoneId ~= currentZoneId and
                player:hasTeleport(xi.teleport.type.SURVIVAL, guide.groupIndex - 1, guide.group - 1) -- Destination check.
            then
                local teleportCostGil  = 1000
                local teleportCostTabs = 50
                local canTeleport      = false

                -- If the player has the "Rhapsody in White" KI, the cost is 10% of original gil or 20% of original tabs.
                -- GIL: 1000 -> 100
                -- TABS: 50 -> 10
                if player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
                    teleportCostGil  = teleportCostGil / 10
                    teleportCostTabs = teleportCostTabs / 5
                end

                -- Currency checks.
                if bit.band(bit.rshift(option, 8), 1) == 1 then
                    -- Paying with tabs
                    if player:getCurrency('valor_point') > teleportCostTabs then
                        player:delCurrency('valor_point', teleportCostTabs)
                        canTeleport = true
                    end
                else
                    if player:getGil() > teleportCostGil then
                        player:delGil(teleportCostGil)
                        canTeleport = true
                    end
                end

                if canTeleport then
                    player:setPos(guide.posX, guide.posY, guide.posZ, guide.posRot, guide.zoneId)
                end
            end
        end
    end
end
