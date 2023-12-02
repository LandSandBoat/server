-----------------------------------
-- Area: The Shrouded Maw
--  Mob: Diabolos
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local useCamisado = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)

    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            -- Camisado
            mobArg:useMobAbility(656)
        end
    end)

    mob:timer(7000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end
    end)
end

-- TODO: CoP Diabolos
-- 1) Make the diremites in the pit all aggro said player that falls into region. Should have a respawn time of 10 seconds.
-- 2) Diremites also shouldnt follow you back to the fight area if you make it there. Should despawn and respawn instantly if all players
--    make it back to the Diabolos floor area.

entity.onMobSpawn = function(mob)
    local dBase = ID.mob.DIABOLOS_OFFSET
    local dPrimeBase = dBase + 27
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)

    -- Only add these for the CoP Diabolos NOT Prime
    if mob:getID() >= dBase and mob:getID() <= dBase + 14 then  -- three possible instances of Diabolos
        mob:addMod(xi.mod.INT, -50)
        mob:addMod(xi.mod.MND, -50)
        mob:addMod(xi.mod.ATTP, -15)
        mob:addMod(xi.mod.DEFP, -15)
        mob:addMod(xi.mod.MDEF, -40)
        -- If this is CoP mission Diabolos then no 2hr
        xi.mix.jobSpecial.config(mob, { specials = { }, })
    else
    -- If this is Diabolos Prime, give him Ruinous Omen
        xi.mix.jobSpecial.config(mob, {
            specials =
            {
                { id = 1911, hpp = math.random(30, 55) }, -- uses Ruinous Omen once while near 50% HPP.
            },
        })
    end

    -- Tile Drop Trigger:  Max HPP = 76%, Min HPP = 20%, Gap = 56%, Half = 28%
    local triggerVal = math.random(1, 28) + math.random(1, 28) + 18

    -- If this is prime, adjust the "base" to be the prime set
    -- Prime "block" of mobs is offset 27 from CoP mobs
    if mob:getID() >= dPrimeBase then
        dBase = dPrimeBase
    end

    local area = utils.clamp((mob:getID() - dBase) / 7 + 1, 1, 3)

    mob:setLocalVar("TileTriggerHPP", triggerVal) -- Starting point for tile drops
    mob:setLocalVar("Area", area)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
end

entity.onMobFight = function(mob, target)
    local area = mob:getLocalVar("Area") - 1
    local trigger = mob:getLocalVar("TileTriggerHPP")

    local tileDrops =
        {   -- { Animation Area 1, Animation Area 2, Animation Area 3 }
            { "byc8", "bya8", "byb8" },
            { "byc7", "bya7", "byb7" },
            { "byc6", "bya6", "byb6" },
            { "byc5", "bya5", "byb5" },
            { "byc4", "bya4", "byb4" },
            { "byc3", "bya3", "byb3" },
            { "byc2", "bya2", "byb2" },
            { "byc1", "bya1", "byb1" },
        }

    local hpp = math.floor(mob:getHP() * 100 / mob:getMaxHP())
    if hpp < trigger then   -- Trigger the tile drop events
        mob:setLocalVar("TileTriggerHPP", -1)            -- Prevent tiles from being dropped twice
        local tileBase = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (area) * 8

        for offset, animationSet in ipairs(tileDrops) do
            local tileId = tileBase + offset - 1
            local tile = GetNPCByID(tileId)

            if tile:getLocalVar("Dropped") ~= xi.anim.OPEN_DOOR then
                tile:setLocalVar("Dropped", xi.anim.OPEN_DOOR)
                SendEntityVisualPacket(tileId, animationSet[area + 1], 4)     -- Animation for floor dropping
                SendEntityVisualPacket(tileId, "s123", 4)          -- Tile dropping sound

                tile:timer(3100, function(t)                 -- 3.1s second delay (ish)
                    t:updateToEntireZone(xi.status.NORMAL, xi.anim.OPEN_DOOR)       -- Floor opens
                end)
            end
        end
    end

    -- Diabolos has regain under 50% HP according to retail capture
    if hpp < 50 then
        if mob:getMod(xi.mod.REGAIN) == 0 then
            -- Regain of 50 implies an TP move every 60 sec when HP > 25%
            mob:setMod(xi.mod.REGAIN, 50)
        end
    else
        if mob:getMod(xi.mod.REGAIN) ~= 0 then
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end
end

-- After Nightmare or Ultimate Terror then always use Camisado
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    -- ToDo this is prob incorrect since this will be triggered for each target hit by a skill
    if skillID == 659 or skillID == 1908 then
        useCamisado(mob)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Win happens on death instead of despawn
    mob:getBattlefield():win()
end

return entity
