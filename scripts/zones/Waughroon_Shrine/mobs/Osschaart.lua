-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Osschaart
-- KSNM30 Copycat
-----------------------------------
--   Variables Documentation:
--
--   Mob Local Variables:
--   charmOrderSize     - Total number of players in randomized charm order (set on engage)
--   charmOrder[1-6]    - Player IDs in randomized charm order (charmOrder1, charmOrder2, etc.)
--   charmIndex         - Current position in charm order (which player to charm next)
--   charmedJob         - Job of the currently charmed player
--   copiedTwoHour      - Ability ID of the copied two-hour ability
--   copiedJob          - Job associated with the copied two-hour ability (used for pet jobs)
--   twoHourHPP         - Random HP threshold (20-65%) to trigger two-hour usage
--   twoHourUsed        - Flag (0/1) indicating if two-hour has been used this fight
--   lastCharmTime      - Timestamp of last charm attempt (for 30-second intervals)
--
--   Function local variables:
--   battlefield        - Battlefield instance for player access
--   drawInConditions   - Defines distance check for drawing in charmed player
--   validPlayers       - Hash table of valid players (inside of the battlefield, alive, not charmed) by ID
--   targetPlayer       - Selected player to charm
--   currentIndex       - Current charm order position
--   playerJob          - Main job of the target player
--   twoHour            - Two-hour ability looked up from table{name, abilityId}
--   copiedTwoHour      - Copied two-hour ability ID (also used as local var)
--   copiedJob          - Copied job (also used as local var)
--   petData            - Pet parameters from pets table
--   petId              - Calculated pet mob ID (mob ID + offset)
--   currentTime        - Current system timestamp
--   lastCharmTime      - Last charm timestamp (also used as local var)
--   mobHPP             - Current mob HP percentage
--   twoHourHPP         - Two-hour trigger threshold (also used as local var)
--   twoHourUsed        - Two-hour usage flag (also used as local var)
-----------------------------------

---@type TMobEntity
local entity = {}

local twoHourAbilities =
{
    [xi.job.WAR] = { name = 'Mighty Strikes',  abilityId = xi.jobSpecialAbility.MIGHTY_STRIKES },
    [xi.job.MNK] = { name = 'Hundred Fists',   abilityId = xi.jobSpecialAbility.HUNDRED_FISTS  },
    [xi.job.WHM] = { name = 'Benediction',     abilityId = xi.jobSpecialAbility.BENEDICTION    },
    [xi.job.BLM] = { name = 'Manafont',        abilityId = xi.jobSpecialAbility.MANAFONT       },
    [xi.job.RDM] = { name = 'Chainspell',      abilityId = xi.jobSpecialAbility.CHAINSPELL     },
    [xi.job.THF] = { name = 'Perfect Dodge',   abilityId = xi.jobSpecialAbility.PERFECT_DODGE  },
    [xi.job.PLD] = { name = 'Invincible',      abilityId = xi.jobSpecialAbility.INVINCIBLE     },
    [xi.job.DRK] = { name = 'Blood Weapon',    abilityId = xi.jobSpecialAbility.BLOOD_WEAPON   },
    [xi.job.BST] = { name = 'Familiar',        abilityId = xi.jobSpecialAbility.FAMILIAR       },
    [xi.job.BRD] = { name = 'Soul Voice',      abilityId = xi.jobSpecialAbility.SOUL_VOICE     },
    [xi.job.RNG] = { name = 'Eagle Eye Shot',  abilityId = xi.jobSpecialAbility.EES_KINDRED    },
    [xi.job.SAM] = { name = 'Meikyo Shisui',   abilityId = xi.jobSpecialAbility.MEIKYO_SHISUI  },
    [xi.job.NIN] = { name = 'Mijin Gakure',    abilityId = xi.jobSpecialAbility.MIJIN_GAKURE   },
    [xi.job.DRG] = { name = 'Call Wyvern',     abilityId = xi.jobSpecialAbility.CALL_WYVERN    },
    [xi.job.SMN] = { name = 'Astral Flow',     abilityId = xi.jobSpecialAbility.ASTRAL_FLOW    },
    [xi.job.BLU] = { name = 'Azure Lore',      abilityId = xi.jobSpecialAbility.AZURE_LORE     },
    [xi.job.COR] = { name = 'Wild Card',       abilityId = xi.jobSpecialAbility.WILD_CARD      },
    [xi.job.PUP] = { name = 'Overdrive',       abilityId = xi.jobSpecialAbility.OVERDRIVE      },
    [xi.job.DNC] = { name = 'Trance',          abilityId = xi.jobSpecialAbility.TRANCE         },
    [xi.job.SCH] = { name = 'Tabula Rasa',     abilityId = xi.jobSpecialAbility.TABULA_RASA    }
}

local pets =
{
    [xi.job.BST] =
    {
        offset = 2,
        name = 'Osschaarts_Bat',
        params =
        {
            callPetJob = xi.job.BST,
            superLink = true,
            dieWithOwner = true,
            maxSpawns = 1
        }
    },

    [xi.job.DRG] =
    {
        offset = 3,
        name = 'Osschaarts_Wyvern',
        params =
        {
            callPetJob = xi.job.DRG,
            superLink = true,
            dieWithOwner = true,
            maxSpawns = 1
        }
    },

    [xi.job.PUP] =
    {
        offset = 5,
        name = 'Osschaarts_Automaton',
        params =
        {
            callPetJob = xi.job.PUP,
            superLink = true,
            dieWithOwner = true,
            maxSpawns = 1
        }
    },
}

-----------------------------------
--- Charm Logic : When this function is called Osschaart will attempt to charm the next player in the charm order that is set on engage.
--- If the player is out of range they will be drawn in before execution.
--- If the player is dead, already charmed or is no longer present in the battlefield, Osschaart will skip to the next player in the order.
--- Once charmed, Osschaart will copy the two-hour ability of the charmed players job for later use.
-----------------------------------
local function charm(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Get the total number of players in the randomized charm order (set during engage)
    local orderSize = mob:getLocalVar('charmOrderSize')
    if orderSize == 0 then
        return
    end

    -- Create lookup table of valid players (inside the battlefield, alive, not already charmed)
    local validPlayers = {}
    for _, player in pairs(battlefield:getPlayers()) do
        if player:isAlive() and not player:hasStatusEffect(xi.effect.CHARM_I) then
            validPlayers[player:getID()] = player
        end
    end

    -- If no valid players, return
    if next(validPlayers) == nil then
        return
    end

    -- Find next valid target starting from current index
    local currentIndex = mob:getLocalVar('charmIndex')
    local targetPlayer = nil

    -- Check players in order starting from currentIndex
    for i = 1, orderSize do
        local checkIndex = ((currentIndex - 1 + i - 1) % orderSize) + 1
        local targetID = mob:getLocalVar('charmOrder' .. checkIndex)

        if validPlayers[targetID] then
            targetPlayer = validPlayers[targetID]
            mob:setLocalVar('charmIndex', (checkIndex % orderSize) + 1)
            break
        end
    end

    if not targetPlayer then
        return
    end

    -- Draw in player if they are out of charm range
    local drawInConditions =
    {
        conditions =
        {
            mob:checkDistance(targetPlayer) == nil or mob:checkDistance(targetPlayer) > 17.5
        },
        position = mob:getPos(),
        wait = 1
    }
    utils.drawIn(targetPlayer, drawInConditions)

    -- Execute charm
    local playerJob = targetPlayer:getMainJob()
    mob:useMobAbility(xi.mobSkill.CHARM_2, targetPlayer)
    mob:setLocalVar('charmedJob', playerJob)

    -- Copy two-hour ability of charmed player and have it ready for use
    local twoHour = twoHourAbilities[playerJob]
    if twoHour then
        mob:setLocalVar('copiedTwoHour', twoHour.abilityId)
        mob:setLocalVar('copiedJob', playerJob)
    end

    -- Update enmity for remaining players after charm
    for _, player in pairs(battlefield:getPlayers()) do
        if player:isAlive() and not player:hasStatusEffect(xi.effect.CHARM_I) then
            mob:updateEnmity(player)
        end
    end
end

-----------------------------------
--- MobInitialize: Sets Astral Flow pet offset, double attack, wind resistance rank and magic cooldown
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 4) -- Sets Avatar at offset +4, so it can be called properly for Astral Flow
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.WIND_RES_RANK, 8) -- Should be extremely hard to silence, but possible with high enough accuracy or elemental seal
end

-----------------------------------
--- MobEngage: Sets up charm order and two-hour HP threshold
-----------------------------------
entity.onMobEngage = function(mob, target)
    -- Prevent re-initialization if charm order is already set
    if mob:getLocalVar('charmOrderSize') > 0 then
        return
    end

    -- Get the battlefield instance to access player list
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Collect all player character IDs from the battlefield on engage
    local players = {}
    for _, p in pairs(battlefield:getPlayers()) do
        if p:isPC() then
            table.insert(players, p:getID())
        end
    end

    -- Shuffle the player list to randomize the charm order
    for i = #players, 2, -1 do
        local j = math.random(i)
        players[i], players[j] = players[j], players[i]
    end

    -- Store the randomized charm order.
    mob:setLocalVar('charmOrderSize', #players)
    for i, id in ipairs(players) do
        mob:setLocalVar('charmOrder' .. i, id)
    end

    -- Sets the charm order to the first player and sets the two-hour HP threshold
    mob:setLocalVar('charmIndex', 1)
    mob:setLocalVar('twoHourHPP', math.random(20, 65))
end

-----------------------------------
---MobFight: Osschaart uses charm on players in a set order every 30 seconds. Will use two-hour ability of charmed players job once per fight when threshold is met
-----------------------------------
entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()
    local lastCharmTime = mob:getLocalVar('lastCharmTime')
    local mobHPP = mob:getHPP()
    local twoHourHPP = mob:getLocalVar('twoHourHPP')
    local twoHourUsed = mob:getLocalVar('twoHourUsed')

    -- Add a busy check here after variables are defined to prevent charm/two-hour usage while busy
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Handle charm timer first
    if
        lastCharmTime == 0 or
        currentTime >= lastCharmTime + 30
    then
        charm(mob)
        mob:setLocalVar('lastCharmTime', currentTime)
        return
    end

    -- Then check if we should use the copied two-hour ability
    if
        mobHPP <= twoHourHPP and
        mob:getLocalVar('copiedTwoHour') > 0 and
        twoHourUsed == 0
    then
        local copiedTwoHour = mob:getLocalVar('copiedTwoHour')
        local copiedJob = mob:getLocalVar('copiedJob')

        -- Handle pet jobs with special summoning logic
        if copiedJob == xi.job.BST then
            -- BST: Summons pet first, then uses Familiar after a 2 second delay
            local petData = pets[xi.job.BST]
            local petId = mob:getID() + petData.offset
            xi.pet.setMobPet(mob, petData.offset, petData.name)
            xi.mob.callPets(mob, petId, petData.params)
            mob:timer(2000, function(mobArg)
                mobArg:useMobAbility(copiedTwoHour)
            end)
        elseif copiedJob == xi.job.PUP then
            -- PUP: Summons automaton first, then uses Overdrive after a 2 second delay
            local petData = pets[xi.job.PUP]
            local petId = mob:getID() + petData.offset
            xi.pet.setMobPet(mob, petData.offset, petData.name)
            xi.mob.callPets(mob, petId, petData.params)
            mob:timer(2000, function(mobArg)
                mobArg:useMobAbility(copiedTwoHour)
            end)
        elseif copiedJob == xi.job.DRG then
            -- DRG: Uses Call Wyvern
            local petData = pets[xi.job.DRG]
            local petId = mob:getID() + petData.offset
            xi.pet.setMobPet(mob, petData.offset, petData.name)
            xi.mob.callPets(mob, petId, petData.params)
        else
            -- All other jobs: Just use the two-hour ability
            mob:useMobAbility(copiedTwoHour)
        end

        mob:setLocalVar('twoHourUsed', 1)
    end
end

-----------------------------------
--- MagicPrepare: Osschaarts spell list
-----------------------------------
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.BLIZZAGA_III,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.THUNDAGA_III,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.WATERGA_III,
        xi.magic.spell.BURST,
        xi.magic.spell.FLOOD,
        xi.magic.spell.DRAIN,
        xi.magic.spell.ASPIR,
        xi.magic.spell.FROST,
        xi.magic.spell.RASP,
        xi.magic.spell.DROWN,
        xi.magic.spell.BLAZE_SPIKES,
        xi.magic.spell.POISONGA_II,
        xi.magic.spell.BIO_II,
        xi.magic.spell.BLIND,
        xi.magic.spell.BIND,
        xi.magic.spell.STUN,
    }

    return spellList[math.random(1, #spellList)]
end

-----------------------------------
-- MobDisengage: Resets charm order on disengage in case of a wipe.
-----------------------------------
entity.onMobDisengage = function(mob)
    mob:setLocalVar('charmOrderSize', 0)
    mob:setLocalVar('charmIndex', 0)
end

return entity
