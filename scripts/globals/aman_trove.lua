-----------------------------------
-- A.M.A.N. Trove
-----------------------------------
xi = xi or {}
xi.amanTrove = xi.amanTrove or {}

-- Balgas Dias
-- 7702 : You hear a loud thud, as if a large amount of spoils spontaneously appeared.
-- 7703 : You hear a thud, as if a large amount of spoils spontaneously appeared.
-- 7704 : You hear a noise, as if a large amount of spoils spontaneously appeared.
-- 7705 : You receive # gil as a bonus reward!
-- 7706 : You hear a belligerent bang from one of the remaining treasure chests.

-----------------------------------
-- General
-----------------------------------
xi.amanTrove.numChests = 10

xi.amanTrove.chestType =
{
    SMALL_LOOT  = 0, -- Noise
    MEDIUM_LOOT = 1, -- Thud
    LARGE_LOOT  = 2, -- Loud Thud
    RAINBOW     = 3, -- Guaranteed Loud Thud (Large)
    GOLD        = 4, -- Guaranteed Thud (Medium)
    MIMIC       = 5,
}

-----------------------------------
-- Mars
-----------------------------------
xi.amanTrove.marsChanceOfPerfectRun = 2.5 -- % chance of being able to get through all chests without a mimic
xi.amanTrove.marsMimicChance = (1.0 - math.pow(xi.amanTrove.marsChanceOfPerfectRun / 100, 1 / xi.amanTrove.numChests)) * 100
-- Works out to: 30.84% chance of a mimic on any chest

-- This is the percentage of the remainder of the roll after the mimic check is done
xi.amanTrove.marsLootChances =
{
    -- Percent chance of each kind of loot.
    -- Must add up to 100!
    SMALL  = 80,
    MEDIUM = 15,
    LARGE  = 5,
}

xi.amanTrove.marsLootLimits =
{
    MEDIUM = 3,
    LARGE  = 2,
}

xi.amanTrove.marsGuaranteedLoot =
{
    MEDIUM = 0,
    LARGE  = 0,
}

-----------------------------------
-- Venus
-----------------------------------
xi.amanTrove.venusChanceOfPerfectRun = 0.5 -- % chance of being able to get through all chests without a mimic
xi.amanTrove.venusMimicChance = (1.0 - math.pow(xi.amanTrove.chanceOfPerfectRun / 100, 1 / xi.amanTrove.numChests)) * 100
-- Works out to: 41.13% chance of a mimic on any chest

-- This is the percentage of the remainder of the roll after the mimic check is done
xi.amanTrove.venusLootChances =
{
    -- Percent chance of each kind of loot.
    -- Must add up to 100!
    SMALL  = 70,
    MEDIUM = 22,
    LARGE  = 8,
}

xi.amanTrove.venusLootLimits =
{
    MEDIUM = 4,
    LARGE  = 3,
}

xi.amanTrove.venusGuaranteedLoot =
{
    MEDIUM = 1,
    LARGE  = 1,
}

-----------------------------------
-- Functions
-----------------------------------
xi.amantrove.setupBattlefield = function(battlefield)
    local zone = battlefield:getZone()
    local ID   = zones[zone:getID()]

    -- Setup Terminal Coffer
    local battleArea     = battlefield:getArea()
    local terminalCoffer = GetNPCByID(ID.npc.TERMINAL_COFFER + (battleArea - 1) * 11)

    -- NPC
    terminalCoffer:setStatus(xi.status.NORMAL)
    terminalCoffer:setUntargetable(false)

    -- Setup Chests (mobs)
    -- We pre-allocate everything rather than rolling on things at trigger-time.
    local mimicChest = math.random(0, 9)

    for i = 0, 9 do
        local chest = GetMobByID(ID.mob.CHEST_O_PLENTY + i + (battleArea - 1) * 11)

        chest:setStatus(xi.status.NORMAL) -- Make mob triggerable
        chest:setUntargetable(false)

        if i == mimicChest then
            chest:setLocalVar('Mimic', 1)
        end
    end
end

xi.amanTrove.chestOPlentyOnTrigger = function(player, npc)
    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end
    npc:setLocalVar('Triggered', 1)

    if npc:getLocalVar('Mimic') == 1 then
        xi.amanTrove.prepareMimic(player, npc)
        return
    end

    local zone = player:getZone()
    local ID   = zones[zone:getID()]

    print("You have triggered the Chest O'Plenty.")

    player:showText(npc, ID.text.LOUD_THUD)

    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    -- TODO: Thuds etc.
end

xi.amanTrove.terminalCofferOnTrigger = function(player, npc)
    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end
    npc:setLocalVar('Triggered', 1)

    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    print("You have triggered the Terminal Coffer.")

    -- TODO: Count up thuds, etc. generate loot

    -- TODO: We're going to predetermine how many thuds etc. there are
    --     : available at the start of the BC. If somehow we get to this point
    --     : and there are more than we allocated - then the player has managed
    --     : to cheat and we should report it and make sure they don't get any
    --     : loot!
end

xi.amanTrove.prepareMimic = function(player, npc)
    print("The chest is a mimic!")

    npc:setStatus(xi.status.UPDATE)
    npc:setModelId(258)
    npc:setAnimation(1) -- Combat
    npc:setAnimationSub(1) -- Mouth open

    -- Make things disappear:
    -- npc:entityAnimationPacket('kesu', npc)

    -- TODO: Make all other closed chests disappear, open chests remain.
    -- TODO: Change model into animated mimic, make name visible, set enmity, etc.
end
