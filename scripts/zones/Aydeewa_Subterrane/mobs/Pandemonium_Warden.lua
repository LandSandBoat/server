-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Warden
--
-- !pos 200 33 -140 68
-- Spawn by trading Pandemonium key: !additem 2572
-- Wiki: https://ffxiclopedia.fandom.com/wiki/Pandemonium_Warden
--       https://www.bg-wiki.com/ffxi/Pandemonium_Warden
-- Videos: https://youtu.be/oOCCjH8isiA
--         https://youtu.be/T_Us2Tmlm-E
--         https://youtu.be/fvgG8zfqr2o
--         https://youtu.be/BPbsHhbi4LE
--
-- Notes: See Pandemonium_Warden_HNM.lua for details on intermediate phases. This file will refer specifically to the behavior of this mob's short sequences between phases and the final form
--        spawns and immedaitely performs his sequence:
--          Cannot be damaged, doesn't autoattack/cast
--          calls 6 corpselight pets, which do nothing but follow their target
--          uses cackle
--          uses hellsnap
--          disappears himself and Lamps (pets)
--          Other mobId spawns in the particular phase, with fresh enmity table
--          when mob is defeated, does the same thing as before
--
--        When final intermediate phase is defeated, PW appears in final form
--          calls all 8 base pets in Dverger form
--          can be damaged/killed
--          pets and himself have access to BLM spells and Dverger mobskills
--          performs an astral flow sequence every 25% hp
--            calls secondary pet group: amount based on living Lamps + himself (i.e if he has 4 lamps up, he will call 5 avatars)
--            12s later PW will AF and his avatars will use their respective abilities and die
--              Everyone except tank should be prepared to get away when this happens, though there's plenty of time to run away unless you get stun locked by pet spells
--              "All avatars are summoned at once, and with them plus the lamps up, its hard to move your character."
--              "You will probably get locked in place and die from game mechanics alone."
-- TODO pet groups are: first 8 for all phase pets, final 9 are specifically for astral flow avatars
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Pet Arrays, we'll alternate between phases
local petIDs = {}
petIDs[0] =
{
    ID.mob.PANDEMONIUM_WARDEN + 2,
    ID.mob.PANDEMONIUM_WARDEN + 3,
    ID.mob.PANDEMONIUM_WARDEN + 4,
    ID.mob.PANDEMONIUM_WARDEN + 5,
    ID.mob.PANDEMONIUM_WARDEN + 6,
    ID.mob.PANDEMONIUM_WARDEN + 7,
    ID.mob.PANDEMONIUM_WARDEN + 8,
    ID.mob.PANDEMONIUM_WARDEN + 9
}
petIDs[1] =
{
    ID.mob.PANDEMONIUM_WARDEN + 10,
    ID.mob.PANDEMONIUM_WARDEN + 11,
    ID.mob.PANDEMONIUM_WARDEN + 12,
    ID.mob.PANDEMONIUM_WARDEN + 13,
    ID.mob.PANDEMONIUM_WARDEN + 14,
    ID.mob.PANDEMONIUM_WARDEN + 15,
    ID.mob.PANDEMONIUM_WARDEN + 16,
    ID.mob.PANDEMONIUM_WARDEN + 17
}

-- Phase Arrays      Dverg,  Char1, Dverg,  Char2, Dverg,  Char3, Dverg,  Char4,  Dverg,   Mamo,  Dverg,  Lamia,  Dverg,  Troll,  Dverg,   Cerb,  Dverg,  Hydra,  Dverg,   Khim,  Dverg
--                       1       2      3       4      5       6      7       8       9      10      11      12      13      14      15      16      17      18      19      20
local triggerHPP = {    95,      1,    95,      1,    95,      1,    95,      1,     95,      1,     95,      1,     95,      1,     95,      1,     95,      1,     95,      1 }
local mobHP =      { 10000, 147000, 10000, 147000, 10000, 147000, 10000, 147000,  15000, 147000,  15000, 147000,  15000, 147000,  20000, 147000,  20000, 147000,  20000, 147000 }
local mobModelID = {  1825,   1840,  1825,   1840,  1825,   1840,  1825,   1840,   1863,   1840,   1865,   1840,   1867,   1840,   1793,   1840,   1796,   1840,   1805,   1840 }
local petModelID = {  1823,   1841,  1821,   1841,  1825,   1841,  1824,   1841,   1639,   1841,   1643,   1841,   1680,   1841,    281,   1841,    421,   1841,   1746,   1839 }
local skillID =    {  1000,    316,  1001,    316,  1002,    316,  1003,    316,    285,    316,    725,    316,    326,    316,     62,    316,    164,    316,    168,    316 }

-- Avatar Arrays         Shiva, Ramuh, Titan, Ifrit, Levia, Garud, Fenri, Carby
local avatarAbilities = {  917,   918,   914,   913,   915,   916,   839,   919 }
local avatarSkins =     {   22,    23,    19,    18,    20,    21,    17,    16 }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 450)
    mob:setMod(xi.mod.MEVA, 380)
    mob:setMod(xi.mod.MDEF, 50)
    -- Make sure model is reset back to start
    mob:setModelId(1840)
    -- Prevent death and hide HP until final phase
    mob:setUnkillable(true)
    mob:hideHP(true)

    -- Two hours to forced depop
    mob:setLocalVar('PWDespawnTime', GetSystemTime() + 7200)
    mob:setLocalVar('phase', 1)
    mob:setLocalVar('astralFlow', 1)

    mob:showText(mob, ID.text.PW_WHO_DARES)
end

entity.onMobDisengage = function(mob)
    -- Make sure model is reset back to start
    mob:setModelId(1840)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 316)

    -- Prevent death and hide HP until final phase
    mob:setUnkillable(true)
    mob:hideHP(true)

    -- Reset phases (but not despawn timer)
    mob:setLocalVar('phase', 1)
    mob:setLocalVar('astralFlow', 1)

    -- Despawn pets
    for i = 0, 1 do
        for j = 1, 8 do
            if GetMobByID(petIDs[i][j]):isSpawned() then
                DespawnMob(petIDs[i][j])
            end
        end
    end
end

entity.onMobEngage = function(mob, target)
    -- pop pets
    for i = 1, 8 do
        local pet = GetMobByID(petIDs[1][i])

        if pet then
            pet:setModelId(1841)
            pet:spawn()
            pet:updateEnmity(target)
        end
    end
end

local function handlePet(mob, newPet, oldPet, target, modelId)
    if oldPet:isSpawned() then
        DespawnMob(oldPet:getID())
    end

    newPet:setModelId(modelId)
    newPet:spawn()
    newPet:setPos(mob:getXPos() + math.random(-2, 2), mob:getYPos(), mob:getZPos() + math.random(-2, 2))
    newPet:updateEnmity(target)
end

entity.onMobFight = function(mob, target)
    -- Init Vars
    local mobHPP    = mob:getHPP()
    local depopTime = mob:getLocalVar('PWDespawnTime')
    local phase     = mob:getLocalVar('phase')
    local astral    = mob:getLocalVar('astralFlow')
    local pets      = {}

    for i = 0, 1 do
        pets[i] = {}
        for j = 1, 8 do
            pets[i][j] = GetMobByID(petIDs[i][j])
        end
    end

    -- Check for phase change
    if
        phase < 21 and
        mobHPP <= triggerHPP[phase]
    then
        if phase == 20 then -- Prepare for death
            mob:hideHP(false)
            mob:setUnkillable(false)
        end

        -- Change phase
        mob:setTP(0)
        mob:setModelId(mobModelID[phase])
        mob:setHP(mobHP[phase])
        mob:setMobMod(xi.mobMod.SKILL_LIST, skillID[phase])

        -- Handle pets
        for i = 1, 8 do
            local oldPet = pets[phase % 2][i]
            local newPet = pets[(phase - 1) % 2][i]
            newPet:updateEnmity(target)
            newPet:setMobMod(xi.mobMod.MAGIC_DELAY, 4)
            handlePet(mob, newPet, oldPet, target, petModelID[phase])
        end

        -- Increment phase
        mob:setLocalVar('phase', phase + 1)

    -- Or, check for Astral Flow
    elseif
        phase == 21 and
        astral < 9 and
        mobHPP <= (100 - 25 * astral)
    then
        for i = 1, 8 do
            local oldPet = pets[astral % 2][i]
            local newPet = pets[(astral - 1) % 2][i]

            if i == 1 then
                newPet:updateEnmity(target)
                local astralRand = math.random(1, 8)
                handlePet(mob, newPet, oldPet, target, avatarSkins[astralRand])
                newPet:useMobAbility(avatarAbilities[astralRand])
            else
                handlePet(mob, newPet, oldPet, target, 1839)
            end
        end

        -- Increment astral
        mob:setLocalVar('astralFlow', astral + 1)

    -- Or, at least make sure pets weren't drug off
    else
        --[[ Unused
        for i = 1, 8 do
            local pet = nil
            if phase == 21 then
                pet = pets[astral % 2][i]
            else
                pet = pets[phase % 2][i]
            end
        end
        ]]--
    end

    -- Check for time limit, too
    if
        GetSystemTime() > depopTime and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        for i = 0, 1 do
            for j = 1, 8 do
                if pets[i][j]:isSpawned() then
                    DespawnMob(petIDs[i][j])
                end
            end
        end

        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.PANDEMONIUM_QUELLER)
    end

    if optParams.isKiller or optParams.noKiller then
        mob:showText(mob, ID.text.PW_WHO_DARES + 1)
    end

    -- Despawn pets
    for i = 0, 1 do
        for j = 1, 8 do
            if GetMobByID(petIDs[i][j]):isSpawned() then
                DespawnMob(petIDs[i][j])
            end
        end
    end
end

entity.onMobDespawn = function(mob)
    -- Despawn pets
    for i = 0, 1 do
        for j = 1, 8 do
            if GetMobByID(petIDs[i][j]):isSpawned() then
                DespawnMob(petIDs[i][j])
            end
        end
    end
end

return entity
