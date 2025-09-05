-----------------------------------
-- Assault Utilities
-- desc: Common functionality for Assaults
-----------------------------------
require('scripts/globals/besieged')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/container')
-----------------------------------
xi = xi or {}
xi.assault = xi.assault or {}
xi.assault.contents = xi.assault.contents or {}
xi.assault.contentsByZone = xi.assault.contentsByZone or {}

xi.assault.assaultOrders =
{
    xi.ki.LEUJAOAM_ASSAULT_ORDERS,
    xi.ki.MAMOOL_JA_ASSAULT_ORDERS,
    xi.ki.LEBROS_ASSAULT_ORDERS,
    xi.ki.PERIQIA_ASSAULT_ORDERS,
    xi.ki.ILRUSI_ASSAULT_ORDERS,
    xi.ki.NYZUL_ISLE_ASSAULT_ORDERS,
}

xi.assault.levelCapOptions =
{
    [0] = 0,   -- No level cap
    [1] = 70,  -- Level 70 cap
    [2] = 60,  -- Level 60 cap
    [3] = 50,  -- Level 50 cap
}

xi.assault.fireflies =
{
    [xi.zone.MAMOOL_JA_TRAINING_GROUNDS] = xi.item.CAGE_OF_BHAFLAU_FIREFLIES,
    [xi.zone.LEUJAOAM_SANCTUM]           = xi.item.CAGE_OF_AZOUPH_FIREFLIES,
    [xi.zone.LEBROS_CAVERN]              = xi.item.CAGE_OF_ZHAYOLM_FIREFLIES,
    [xi.zone.ILRUSI_ATOLL]               = xi.item.CAGE_OF_REEF_FIREFLIES,
    [xi.zone.PERIQIA]                    = xi.item.CAGE_OF_DVUCCA_FIREFLIES,
}

local shops =
{
    [xi.assault.assaultArea.LEUJAOAM_SANCTUM] =
    {
        [1]  = { itemid = xi.item.STOIC_EARRING,                price =  3000 },
        [2]  = { itemid = xi.item.UNFETTERED_RING,              price =  5000 },
        [3]  = { itemid = xi.item.TEMPERED_CHAIN,               price =  8000 },
        [4]  = { itemid = xi.item.POTENT_BELT,                  price = 10000 },
        [5]  = { itemid = xi.item.MIRACULOUS_CAPE,              price = 10000 },
        [6]  = { itemid = xi.item.YIGIT_BULAWA,                 price = 10000 },
        [7]  = { itemid = xi.item.IMPERIAL_BHUJ,                price = 15000 },
        [8]  = { itemid = xi.item.PAHLUWAN_PATAS,               price = 15000 },
        [9]  = { itemid = xi.item.AMIR_KOLLUKS,                 price = 15000 },
        [10] = { itemid = xi.item.PAHLUWAN_QALANSUWA,           price = 20000 },
        [11] = { itemid = xi.item.YIGIT_SERAWEELS,              price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price  = 3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS] =
    {
        [1]  = { itemid = xi.item.ANTIVENOM_EARRING,            price =  3000 },
        [2]  = { itemid = xi.item.EBULLIENT_RING,               price =  5000 },
        [3]  = { itemid = xi.item.ENLIGHTENED_CHAIN,            price =  8000 },
        [4]  = { itemid = xi.item.SPECTRAL_BELT,                price = 10000 },
        [5]  = { itemid = xi.item.BULLSEYE_CAPE,                price = 10000 },
        [6]  = { itemid = xi.item.STORM_TULWAR,                 price = 15000 },
        [7]  = { itemid = xi.item.IMPERIAL_NEZA,                price = 15000 },
        [8]  = { itemid = xi.item.STORM_TABAR,                  price = 15000 },
        [9]  = { itemid = xi.item.YIGIT_GAGES,                  price = 20000 },
        [10] = { itemid = xi.item.AMIR_BOOTS,                   price = 20000 },
        [11] = { itemid = xi.item.PAHLUWAN_SERAWEELS,           price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.LEBROS_CAVERN] =
    {
        [1]  = { itemid = xi.item.INSOMNIA_EARRING,             price =  3000 },
        [2]  = { itemid = xi.item.HALE_RING,                    price =  5000 },
        [3]  = { itemid = xi.item.CHIVALROUS_CHAIN,             price =  8000 },
        [4]  = { itemid = xi.item.PRECISE_BELT,                 price = 10000 },
        [5]  = { itemid = xi.item.INTENSIFYING_CAPE,            price = 10000 },
        [6]  = { itemid = xi.item.IMPERIAL_POLE,                price = 15000 },
        [7]  = { itemid = xi.item.DOOMBRINGER,                  price = 15000 },
        [8]  = { itemid = xi.item.SAYOSAMONJI,                  price = 15000 },
        [9]  = { itemid = xi.item.PAHLUWAN_DASTANAS,            price = 20000 },
        [10] = { itemid = xi.item.YIGIT_CRACKOWS,               price = 20000 },
        [11] = { itemid = xi.item.AMIR_KORAZIN,                 price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.PERIQIA] =
    {
        [1]  = { itemid = xi.item.VISION_EARRING,               price =  3000 },
        [2]  = { itemid = xi.item.UNYIELDING_RING,              price =  5000 },
        [3]  = { itemid = xi.item.FORTIFIED_CHAIN,              price =  8000 },
        [4]  = { itemid = xi.item.RESOLUTE_BELT,                price = 10000 },
        [5]  = { itemid = xi.item.BUSHIDO_CAPE,                 price = 10000 },
        [6]  = { itemid = xi.item.KHANJAR,                      price = 15000 },
        [7]  = { itemid = xi.item.HOTARUMARU,                   price = 15000 },
        [8]  = { itemid = xi.item.IMPERIAL_GUN,                 price = 15000 },
        [9]  = { itemid = xi.item.AMIR_PUGGAREE,                price = 20000 },
        [10] = { itemid = xi.item.PAHLUWAN_CRACKOWS,            price = 20000 },
        [11] = { itemid = xi.item.YIGIT_GOMLEK,                 price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.ILRUSI_ATOLL] =
    {
        [1]  = { itemid = xi.item.VELOCITY_EARRING,             price =  3000 },
        [2]  = { itemid = xi.item.GARRULOUS_RING,               price =  5000 },
        [3]  = { itemid = xi.item.GRANDIOSE_CHAIN,              price =  8000 },
        [4]  = { itemid = xi.item.HURLING_BELT,                 price = 10000 },
        [5]  = { itemid = xi.item.INVIGORATING_CAPE,            price = 10000 },
        [6]  = { itemid = xi.item.IMPERIAL_KAMAN,               price = 15000 },
        [7]  = { itemid = xi.item.STORM_ZAGHNAL,                price = 15000 },
        [8]  = { itemid = xi.item.STORM_FIFE,                   price = 15000 },
        [9]  = { itemid = xi.item.YIGIT_TURBAN,                 price = 20000 },
        [10] = { itemid = xi.item.AMIR_DIRS,                    price = 20000 },
        [11] = { itemid = xi.item.PAHLUWAN_KHAZAGAND,           price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },
}

local InstanceAssault   = setmetatable({}, { __index = Container })
InstanceAssault.__index = InstanceAssault

---@diagnostic disable-next-line: duplicate-set-field
InstanceAssault.__eq = function(m1, m2)
    return m1.id == m2.id
end

function InstanceAssault.getVarPrefix(assaultID)
    return string.format('Assault[%d]', assaultID)
end

-- Create a new assault instance container. Below are the required data entries
-- - assaultID:      ID of the assault
-- - instanceID:     ID of the global instance
-- - requiredOrders: Required orders to enter and register the assault
-- - zoneID:         ID of the zone
-- - assaultArea:    Area of the assault used in assault point currency

-- - entranceParams:   { instanceID { Assault specific Runic Portal CS + options } { Zone specific entry params } { Joining member entry params } }
-- - runeOfReleasePos: Position of Rune of Release upon completion
-- - ancientBoxPos:    Position of Ancient Lockbox upon completion
-- - releasePos:       Position coordinates for messageSpecial announcing where the rune of release is located
--                       Indexing begins at A = 0. E.x. H = 7

-- - timeLimit:        Time limit in minutes
-- - suggestedLevel:   Suggested level of the assault, this effects points rewarded
-- - requiredProgress: The required progress for the assault to auto-complete
-- - basePoints:       The base amount of points rewarded before bonuses and penalties are applied

-- - loot:     TO BE IMPLEMENTED
-- - mobs:     Mobs to be spawned at the beginning of the instance. Formatting is as such:
--               baseID = someValue, offset = 10 - spawns the next 10 mobs from the base ID given
-- - npcs:     Behave similar to mobs in that they use a group + offset convention
--               baseID = someValue, offset = 2  - spawns the next 10 mobs from the base ID given
-- - wallNPCs  Many assaults use NPC doors that close and open from assault to assault. These NPCs should be
--             set to closed by default. Defining NPCs in this table will open them upon assault initiation

-- - Added behavior to instance function calls that are unique to an assault's behavior.
-- - afterInstanceRegister = function(player)
-- - onInstanceCreated = function(instance)
-- - onInstanceProgressUpdate = function(instance, progress)
-- - onInstanceComplete = function(instance)
-- - onEventUpdate = function(player, csid, option, npc)
-- - onEventFinish = function(player, csid, option, npc)

---@diagnostic disable-next-line: duplicate-set-field
---@param data table
function InstanceAssault:new(data)
    local obj = Container:new(InstanceAssault.getVarPrefix(data.assaultID))
    setmetatable(obj, self)

    obj.assaultID        = data.assaultID
    obj.instanceID       = data.instanceID
    obj.requiredOrders   = data.requiredOrders
    obj.zoneID           = data.zoneID
    obj.assaultArea      = data.assaultArea

    obj.entranceParams   = data.entranceParams or {}
    obj.runeOfReleasePos = data.runeOfReleasePos or {}
    obj.ancientBoxPos    = data.ancientBoxPos or {}
    obj.releasePos       = data.releasePos or {}

    obj.timeLimit        = data.timeLimit
    obj.suggestedLevel   = data.suggestedLevel
    obj.requiredProgress = data.requiredProgress
    obj.basePoints       = data.basePoints

    obj.loot     = {}
    obj.mobs     = {}
    obj.npcs     = {}
    obj.wallNPCs = {}

    obj.afterInstanceRegister = data.afterInstanceRegister or function(player)
    end

    obj.onInstanceCreated = data.onInstanceCreated or function(instance)
    end

    obj.onInstanceProgressUpdate = data.onInstanceProgressUpdate or function(instance, progress)
    end

    obj.onInstanceComplete = data.onInstanceComplete or function(instance)
    end

    obj.onEventUpdate = data.onEventUpdate or function(player, csid, option, npc)
    end

    obj.onEventFinish = data.onEventFinish or function(player, csid, option, npc)
    end

    return obj
end

function InstanceAssault:register()
    -- Add container to global lookup
    xi.assault.contents[self.assaultID] = self
    xi.assault.contentsByZone[self.zoneID] = xi.assault.contentsByZone[self.zoneID] or {}
    table.insert(xi.assault.contentsByZone[self.zoneID], self)

    -- Create a dynamic instance object
    local instanceObject = {}

    -- Registry and entry requirements
    instanceObject.registryRequirements = function(player)
        return xi.assault.checkRequirements(player, self) and
            player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)
    end

    instanceObject.entryRequirements = function(player)
        return xi.assault.checkRequirements(player, self)
    end

    -- Callback functions
    instanceObject.afterInstanceRegister = function(player)
        self.afterInstanceRegister(player)
        xi.assault.afterInstanceRegistration(player, self)
    end

    instanceObject.onInstanceCreated = function(instance)
        self.onInstanceCreated(instance)
    end

    instanceObject.onInstanceCreatedCallback = function(player, instance)
        xi.assault.onInstanceCreatedCallback(player, instance, self)
    end

    instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
        xi.instance.updateInstanceTime(instance, elapsed, zones[self.zoneID].text)
    end

    instanceObject.onInstanceFailure = function(instance)
        xi.assault.onInstanceFailure(instance)
    end

    instanceObject.onInstanceProgressUpdate = function(instance, progress)
        self.onInstanceProgressUpdate(instance, progress)
        if
            self.requiredProgress and
            progress >= self.requiredProgress and
            not instance:completed()
        then
            instance:complete()
        end
    end

    instanceObject.onInstanceComplete = function(instance)
        self.onInstanceComplete(instance)
        local pos = self.releasePos
        xi.assault.onInstanceComplete(instance, pos.x, pos.z)
    end

    instanceObject.onEventUpdate = function(player, csid, option, npc)
        self.onEventUpdate(player, csid, option, npc)
    end

    instanceObject.onEventFinish = function(player, csid, option, npc)
        self.onEventFinish(player, csid, option, npc)
    end

    return instanceObject
end

xi.assault.getAssaultArea = function(player)
    return math.floor((player:getCurrentAssault() - 1) / 10)
end

xi.assault.hasOrders = function(player)
    for _, assaultOrders in pairs(xi.assault.assaultOrders) do
        if player:hasKeyItem(assaultOrders) then
            return true
        end
    end

    return false
end

-- This func serves as a wrapper for instance's onEventUpdate to handle assault specific behaviors
xi.assault.onAssaultUpdate = function(player, csid, option, npc)
    local levelCap = xi.assault.levelCapOptions[bit.band(option, 0x03)]
    local ID       = zones[player:getZoneID()]

    player:setLocalVar('AssaultCap', levelCap)

    if
        player:getGMLevel() == 0 and
        player:getPartySize() < xi.settings.main.ASSAULT_MINIMUM
    then
        player:messageSpecial(ID.text.MEMBER_TOO_FAR - 1, xi.settings.main.ASSAULT_MINIMUM)
        player:instanceEntry(npc, 1)
        return
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageText(player, ID.text.MEMBER_NO_REQS + 1, false)
        player:instanceEntry(npc, 1)
        return
    end

    xi.instance.onEventUpdate(player, csid, option)
end

-- Search first for eligible assaults. If failed search instead for eligible instances
xi.assault.onRunicTrigger = function(player, npc, zone)
    local chosenAssault
    for _, eligibleAssault in ipairs(xi.assault.contentsByZone[zone]) do
        if
            xi.assault.checkRequirements(player, eligibleAssault) and
            player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)
        then
            chosenAssault = eligibleAssault
            break
        end
    end

    if chosenAssault == nil then
        if not xi.instance.onTrigger(player, npc, zone) then
            player:messageSpecial(zones[player:getZoneID()].text.NOTHING_HAPPENS)
            return
        end
    else
        xi.instance.clearInstance(player)
        player:setLocalVar('INSTANCE_ID', chosenAssault.instanceID)
        player:startEvent(unpack(chosenAssault.entranceParams[2]))
    end
end

-- This func serves as a wrapper for instance's onEventFinish to be able to pass through the appropriate params
-- without the use of a global instance table lookup, and to isolate assault-specific information.
xi.assault.onEventFinish = function(player, csid, option, npc)
    local assaultInfo = xi.assault.contents[player:getCurrentAssault()]
    xi.instance.onEventFinish(player, csid, option, npc, assaultInfo.entranceParams[3])
end

-- This func serves as a wrapper for instance's onInstanceCreatedCallback to handle assault-specific checks
xi.assault.onInstanceCreatedCallback = function(player, instance, content)
    if instance then
        instance:setLevelCap(player:getLocalVar('AssaultCap'))
        player:setLocalVar('AssaultCap', 0)
        player:setCharVar('Assault_Armband', 1)
        player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
    else
        local npc = player:getEventTarget()
        player:messageText(player, zones[player:getZoneID()].text.CANNOT_ENTER, false)
        player:instanceEntry(npc, 3)
    end

    if content ~= nil then
        xi.instance.onInstanceCreatedCallback(player, instance, content.entranceParams)
    end
end

-- Setup entities for the assault's instance
xi.assault.afterInstanceRegistration = function(player, content)
    local instance  = player:getInstance()
    local levelCap  = instance:getLevelCap()
    local ID        = zones[content.zoneID]
    local rPos      = content.runeOfReleasePos
    local aPos      = content.ancientBoxPos

    player:setCharVar('assaultEntered', content.assaultID)
    player:messageSpecial(ID.text.ASSAULT_START_OFFSET + content.assaultID, content.assaultID)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, content.timeLimit)
    player:addTempItem(xi.assault.fireflies[content.zoneID])

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(rPos.x, rPos.y, rPos.z, rPos.rot)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(aPos.x, aPos.y, aPos.z, aPos.rot)

    if levelCap ~= 0 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, levelCap, 0, 0)
    end

    if content.mobs then
        for _, group in pairs(content.mobs) do
            for mobID = group.baseID, group.baseID + group.offset, 1 do
                SpawnMob(mobID, instance)
            end
        end
    end

    if content.npcs then
        for _, group in pairs(content.npcs) do
            for npcID = group.baseID, group.baseID + group.offset, 1 do
                GetNPCByID(npcID, instance):setAnimation(xi.status.NORMAL)
            end
        end
    end

    if content.wallNPCs then
        for _, npc in pairs(content.wallNPCs) do
            GetNPCByID(npc, instance):setAnimation(xi.animation.OPEN_DOOR)
        end
    end
end

xi.assault.afterInstanceRegister = function(player, fireFlies)
    local instance = player:getInstance()
    local assaultID = player:getCurrentAssault()
    local levelCap = instance:getLevelCap()
    local ID = zones[player:getZoneID()]

    player:setCharVar('assaultEntered', assaultID)
    player:messageSpecial(ID.text.ASSAULT_START_OFFSET + assaultID, assaultID)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:addTempItem(fireFlies)

    if levelCap ~= 0 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, levelCap, 0, 0)
    end

    for _, entity in pairs(ID.mob[assaultID].MOBS_START) do
        SpawnMob(entity, instance)
    end
end

xi.assault.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _, entity in pairs(mobs) do
        local mobID = entity:getID()
        DespawnMob(mobID, instance)
    end

    for _, entity in pairs(chars) do
        entity:messageSpecial(zones[instance:getZone():getID()].text.MISSION_FAILED, 10, 10)
        entity:startEvent(102)
    end
end

-- TODO: Update parameters once all assaults have been converted
-- posX and posZ can be passed in as one object in the new system
xi.assault.onInstanceComplete = function(instance, posX, posZ)
    local chars = instance:getChars()
    local ID    = zones[instance:getZone():getID()]

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(xi.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(xi.status.NORMAL)

    for _, entity in pairs(chars) do
        entity:messageSpecial(ID.text.RUNE_UNLOCKED_POS, posX, posZ)
    end
end

-- TODO: Combine this with runeReleaseFinish when all assaults have been converted
xi.assault.instanceOnEventFinish = function(player, csid, zone)
    if csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()
        for _, entity in pairs(chars) do
            entity:setPos(0, 0, 0, 0, zone)
        end
    end
end

-- TODO: Update after all assaults after been converted to use container framework
xi.assault.runeReleaseFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        local instance       = player:getInstance()
        local assaultID      = player:getCurrentAssault()
        local chars          = instance:getChars()
        local playerPointMod = math.max((#chars - 3) * 0.1, 0)
        local pointsArea     = xi.assault.getAssaultArea(player)
        local basePoints     = xi.assault.missionInfo[assaultID].minimumPoints
        local promotionBonus = 1

        -- Base points rewarded
        local points = basePoints - (basePoints * playerPointMod)

        -- Add points bonuses
        for _, member in pairs(chars) do
            if member:getLocalVar('AssaultPointsAwarded') == 0 then
                member:setLocalVar('AssaultPointsAwarded', 1)

                -- Leader Bonus
                if member:getCharVar('Assault_Armband') == 1 then
                    points = points * 1.1
                end

                -- First time completion bonuses
                if not member:hasCompletedAssault(assaultID) then
                    promotionBonus = 5
                    points = points * 1.5
                end

                -- TODO: Add bonus points here that are achievable by certain assaults
                member:addAssaultPoint(pointsArea, points)
                member:messageSpecial(zones[player:getZoneID()].text.ASSAULT_POINTS_OBTAINED, points)

                member:setVar('AssaultPromotion', member:getCharVar('AssaultPromotion') + promotionBonus)
                member:setVar('AssaultComplete', 1)

                member:startEvent(102)
            end
        end

        -- Cleanup remaining mobs
        for _, mob in pairs(instance:getMobs()) do
            DespawnMob(mob:getID(), instance)
        end
    end
end

xi.assault.onMissionGiverTrigger = function(player, npc, eventOffset, assaultArea)
    local rank              = xi.besieged.getMercenaryRank(player)
    local hasimperialIDtag  = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints     = player:getAssaultPoint(assaultArea)
    local active            = xi.extravaganza.campaignActive()
    local cipher            = 0

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    if rank > 0 then
        player:startEvent(eventOffset, rank, hasimperialIDtag, assaultPoints, player:getCurrentAssault(), cipher)
    else
        player:startEvent(eventOffset + 6)
    end
end

xi.assault.onMissionGiverUpdate = function(player, csid, option, npc, assaultArea)
    local selectiontype = bit.band(option, 0xF)
    local shop          = shops[assaultArea]

    if csid == 276 and selectiontype == 2 then
        local item          = bit.rshift(option, 14)
        local choice        = shop[item]
        local assaultPoints = player:getAssaultPoint(assaultArea)
        local canEquip      = player:canEquipItem(choice.itemid) and 2 or 0

        player:updateEvent(0, 0, assaultPoints, 0, canEquip)
    end
end

xi.assault.onMissionGiverEventFinish = function(player, csid, option, npc, eventOffset, assaultArea)
    local assaultTable =
    {
        [xi.assault.assaultArea.LEUJAOAM_SANCTUM]           = { orders = xi.ki.LEUJAOAM_ASSAULT_ORDERS,  map = xi.ki.MAP_OF_LEUJAOAM_SANCTUM     },
        [xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS] = { orders = xi.ki.MAMOOL_JA_ASSAULT_ORDERS, map = xi.ki.MAP_OF_THE_TRAINING_GROUNDS },
        [xi.assault.assaultArea.LEBROS_CAVERN]              = { orders = xi.ki.LEBROS_ASSAULT_ORDERS,    map = xi.ki.MAP_OF_LEBROS_CAVERN        },
        [xi.assault.assaultArea.PERIQIA]                    = { orders = xi.ki.PERIQIA_ASSAULT_ORDERS,   map = xi.ki.MAP_OF_ILRUSI_ATOLL         },
        [xi.assault.assaultArea.ILRUSI_ATOLL]               = { orders = xi.ki.ILRUSI_ASSAULT_ORDERS,    map = xi.ki.MAP_OF_PERIQIA              },
    }

    if csid == eventOffset then
        local selectiontype = bit.band(option, 0xF)
        local shop          = shops[assaultArea]
        local assaultInfo   = assaultTable[assaultArea]

        if
            selectiontype == 1 and
            npcUtil.giveKeyItem(player, assaultInfo.orders)
        then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(assaultInfo.map)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = shop[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(assaultArea, choice.price)
            end
        end
    end
end

xi.assault.adjustMobLevel = function(mob)
    local instance     = mob:getInstance()
    local levelCap     = instance:getLevelCap()
    local entity       = GetMobByID(mob:getID(), instance)
    local reducedLevel = 75 - levelCap

    if levelCap ~= 0 then
        if entity then
            entity:setMobLevel(entity:getMainLvl() - reducedLevel)
        end
    end
end

xi.assault.checkRequirements = function(player, content)
    return player:hasKeyItem(content.requiredOrders) and
        player:getCurrentAssault() == content.assaultID and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > content.suggestedLevel and
        (xi.settings.map.ASSAULT_ENABLE_EXPERIMENTAL or not content.experimental)
end

xi.assault.InstanceAssault = InstanceAssault
return InstanceAssault
