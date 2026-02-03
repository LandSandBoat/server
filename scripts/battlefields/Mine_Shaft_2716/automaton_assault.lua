-----------------------------------
-- Automaton Assault
-- Level 60 ENM
-- !addkeyitem SHAFT_GATE_OPERATING_DIAL
-- TODO: Uncomment Gravity resistance in all automatons when implemented
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MINE_SHAFT_2716,
    battlefieldId    = xi.battlefield.id.AUTOMATON_ASSAULT,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 4,
    entryNpc         = '_0d0',
    exitNpcs         = { '_0d1', '_0d2', '_0d3' },
    requiredKeyItems = { xi.ki.SHAFT_GATE_OPERATING_DIAL, message = mineshaftID.text.SNAPS_IN_TWO, },
    grantXP          = 2000,
    armouryCrates    =
    {
        mineshaftID.mob.HUME_AUTOMATON - 1,
        mineshaftID.mob.HUME_AUTOMATON + 5,
        mineshaftID.mob.HUME_AUTOMATON + 11,
    },
})

local raceOffsets =
{
    [xi.race.HUME_M  ] = 0,
    [xi.race.HUME_F  ] = 0,
    [xi.race.ELVAAN_M] = 1,
    [xi.race.ELVAAN_F] = 1,
    [xi.race.TARU_M  ] = 2,
    [xi.race.TARU_F  ] = 2,
    [xi.race.MITHRA  ] = 3,
    [xi.race.GALKA   ] = 4,
}

-----------------------------------
-- Registration Gate - All Races Must Match
-----------------------------------
function content:onEntryEventUpdate(player, csid, option, npc)
    if not player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        local race   = raceOffsets[player:getRace()]
        local zoneId = player:getZoneID()

        for _, member in pairs(player:getAlliance()) do
            if
                member:getZoneID() == zoneId and
                member:getStatus() ~= xi.status.DISAPPEAR
            then
                local memberRace = raceOffsets[member:getRace()]

                if memberRace ~= race then
                    player:updateEvent(xi.battlefield.returnCode.REQS_NOT_MET)
                    player:setLocalVar('noPosUpdate', 1)
                    return 0
                end
            end
        end
    end

    return Battlefield.onEntryEventUpdate(self, player, csid, option, npc)
end

-----------------------------------
-- Build Enemy Group - Exclude Initiators Race
-----------------------------------
local function buildAutomatonGroup(battlefield, initiatorRace)
    local area          = battlefield:getArea()
    local excludeOffset = raceOffsets[initiatorRace] or 0
    local base          = mineshaftID.mob.HUME_AUTOMATON + (area - 1) * 6
    local ids = {}

    for offset = 0, 4 do
        if offset ~= excludeOffset then
            ids[#ids + 1] = base + offset
        end
    end

    local mobIds = { {}, {}, {} }
    mobIds[area] = ids

    return {
        mobIds   = mobIds,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    }
end

-----------------------------------
-- Initialize Battlefield
-----------------------------------
function content:onBattlefieldInitialize(battlefield)
    local initiatorRace = GetPlayerByID(battlefield:getInitiator()):getRace() or xi.race.HUME_M
    local replacedSlot  = raceOffsets[initiatorRace] or 0

    battlefield:setLocalVar('initiatorRace', initiatorRace)
    battlefield:setLocalVar('replacedSlot', replacedSlot)

    self.groups = { buildAutomatonGroup(battlefield, initiatorRace) }
    Battlefield.onBattlefieldInitialize(self, battlefield)
end

-----------------------------------
-- Loot Tables
-----------------------------------
local earringTable =
{
    [0] = { xi.item.BELINKYS_EARRING,    xi.item.QUANTZS_EARRING    }, -- Hume M/F
    [1] = { xi.item.DESAMILIONS_EARRING, xi.item.MELNINAS_EARRING   }, -- Elvaan M/F
    [2] = { xi.item.WAETOTOS_EARRING,    xi.item.MORUKAKAS_EARRING  }, -- Taru M/F
    [3] = { xi.item.RYAKHOS_EARRING,     xi.item.FEYUHS_EARRING     }, -- Mithra
    [4] = { xi.item.ZEDOMAS_EARRING,     xi.item.GAYANJS_EARRING    }, -- Galka
}

local function getLootPool(battlefield)
    -- Get earrings based on race.
    local key      = raceOffsets[battlefield:getLocalVar('initiatorRace')]
    local earring1 = earringTable[key][1]
    local earring2 = earringTable[key][2]

    -- Build loot table.
    local lootTable =
    {
        {
            { itemId = xi.item.SACK_OF_LUGWORM_SAND, weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                 weight =  8000 },
            { itemId = earring1,                     weight =  2000 },
        },

        {
            { itemId = xi.item.NONE,                 weight =  8000 },
            { itemId = earring2,                     weight =  2000 },
        },
    }

    return lootTable or content.loot
end

function content:handleOpenArmouryCrate(player, npc)
    npcUtil.openCrate(npc, function()
        local battlefield = player:getBattlefield()
        local lootPool    = getLootPool(battlefield)

        self:handleLootRolls(battlefield, lootPool, npc, player:getMod(xi.mod.MOGHANCEMENT_GIL_BONUS_P))
        battlefield:setStatus(xi.battlefield.status.WON)

        return true
    end)
end

return content:register()
