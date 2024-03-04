-----------------------------------
-- Area: Al'Taieu
--  HNM: Absolute Virtue
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------

--[[
    misc sources:
    http://rukenshin.livejournal.com/15173.html

    Post-nerf HP: 11k heal at 95% HP. 11000 / (1 - .95) = 220,000
    http://home.eyesonff.com/showthread.php/80870-Absolute-Virtue-Beaten

    Stats: +100 MDB, +132 MAB
    https://www.bluegartr.com/threads/81211-Absolute-Virtue-Information-(OP-Updated)

    - Near instant to instant fast cast
    - Enhanced Movement Speed (~150%)
    - Immune to all enfeebles except Shadowbind, Elemental DoTs, Dia, and Bio [?? - any other exceptions?]
    - Quickly gains resistance to Souleater damage (September '08 patch)
    - Resists Modus Veritas (October '09 patch)

    In addition to the magic defense bonus +100 outlined earlier, AV has a general all damage types reduced that gradually
    increases as its current HP decreases. This applies to all forms of damage - magic, physical, and even non-elemental
    such as Shield Bash. This damage reduction seems to increase proportionally to its remaining HP%
    (for instance, at 50% HP, it has roughly -50% damage taken on top of MDB). It is unknown how this modifier works at extremely
    low HP, since if this reduction remained linear, at 1% HP, it would have 99% damage reduction (virtually unkillable).
]]

-- instead of storing a bunch of numeric vars we will store a global object
xi = xi or {}
xi.av = xi.av or {}

local combos =
{
    [xi.jsa.CHAINSPELL] = { xi.jsa.CHAINSPELL, xi.jsa.MANAFONT, { xi.jsa.CHAINSPELL, xi.jsa.SOUL_VOICE } },
    [xi.jsa.MIGHTY_STRIKES] = { xi.jsa.MIGHTY_STRIKES, xi.jsa.HUNDRED_FISTS },
    [xi.jsa.MEIKYO_SHISUI] = { xi.jsa.MEIKYO_SHISUI, xi.jsa.EES_AERN, xi.jsa.EES_AERN, xi.jsa.EES_AERN },
    [xi.jsa.INVINCIBLE] = { xi.jsa.INVINCIBLE, xi.jsa.BENEDICTION, xi.jsa.MIJIN_GAKURE },
    [xi.jsa.CALL_WYVERN] = { xi.jsa.CALL_WYVERN, xi.jsa.FAMILIAR, xi.jsa.ASTRAL_FLOW },
}

-- TODO: Once AV is stable and accurate, these debug print helpers should be removed
local debugAV = false -- Set to true to get debug prints about AV's behaviour
local debug   = utils.getDebugPlayerPrinter(debugAV)

local entity = {}

entity.handleDamageResists = function(mob)
    local next = mob:getLocalVar('dmgThreshold')
    local current = mob:getHPP()
    if current <= next then
        mob:setLocalVar('dmgThreshold', next - 10)
        local dmg = (100 - current) * -1
        mob:setMod(xi.mod.UDMGPHYS, dmg)
        mob:setMod(xi.mod.UDMGRANGE, dmg)
        mob:setMod(xi.mod.UDMGMAGIC, dmg * 10)
        mob:setMod(xi.mod.UDMGBREATH, dmg)
    end
end

local playerAbilityToMobSP =
{
    [16] =  688, -- MIGHTY_STRIKES
    [17] =  690, -- HUNDRED_FISTS
    [18] =  689, -- BENEDICTION
    [19] =  691, -- MANAFONT
    [20] =  692, -- CHAINSPELL
    [21] =  693, -- PERFECT_DODGE
    [22] =  694, -- INVINCIBLE
    [23] =  695, -- BLOOD_WEAPON
    [24] =  740, -- FAMILIAR
    [25] =  696, -- SOUL_VOICE
    [26] = 1389, -- EES_AERN
    [27] =  730, -- MEIKYO_SHISUI
    [28] =  731, -- MIJIN_GAKURE
    [30] =  734, -- ASTRAL_FLOW
    [61] =  732, -- CALL_WYVERN
}

entity.isLocked = function(sp)
    if #xi.av.sps == 0 then
        return true
    end

    for _, jsa in ipairs(xi.av.sps) do
        if sp == jsa then
            return false
        end
    end

    return true
end

entity.lock = function(sp)
    for i, jsa in ipairs(xi.av.sps) do
        if jsa == sp then
            debug(string.format('locked: %d', sp))
            table.remove(xi.av.sps, i)
            break
        end
    end

    for i, jsa in ipairs(xi.av.braceletsps) do
        if jsa == sp then
            table.remove(xi.av.braceletsps, i)
            break
        end
    end
end

-- TODO: handle pets and pet sp abilities
entity.handleSP = function(mob)
    local now = os.time()
    if now > xi.av.nextsp then
        if xi.av.bracelets and #xi.av.braceletsps ~= 0 then
            local trigger = xi.av.braceletsps[math.random(1, #xi.av.braceletsps)]
            local combo = combos[trigger]
            if trigger == xi.jsa.CHAINSPELL then
                combo = combos[math.random(1, 2)]
            end

            for _, jsa in ipairs(combo) do
                if not entity.isLocked(jsa) then
                    mob:setLocalVar(string.format('sp_%u', jsa), os.time())
                    debug(string.format('%s using %d', mob:getName(), jsa))
                    mob:useMobAbility(jsa)
                end
            end
        elseif #xi.av.sps ~= 0 then
            local sp = xi.av.sps[math.random(1, #xi.av.sps)]
            mob:setLocalVar(string.format('sp_%u', sp), os.time())
            debug(string.format('%s using %d', mob:getName(), sp))
            mob:useMobAbility(sp)
        end

        -- TODO: minimum should be max of 2hr combos length
        xi.av.nextsp = now + math.random(45, 90)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ABILITY_RESPONSE, 1)

    --[[
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(xi.mod.SOULEATERRES, 4)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 150)
    mob:setMod(xi.mod.ATT, 300)
    mob:setMod(xi.mod.DEF, 300)
    mob:setMod(xi.mod.MATT, 132)
    mob:setMod(xi.mod.MDEF, 200)
    mob:setMod(xi.mod.REFRESH, 500)
    mob:setMod(xi.mod.REGAIN, 200)

    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.REQUIEM)

    mob:speed(60)
    ]]--
end

entity.onMobSpawn = function(mob)
    -- reset av
    mob:setAnimationSub(1)

    xi.av.regen = 250
    xi.av.bracelets = false
    xi.av.locks = {}
    xi.av.sps =
    {
        xi.jsa.MIGHTY_STRIKES,
        xi.jsa.BENEDICTION,
        xi.jsa.HUNDRED_FISTS,
        xi.jsa.MANAFONT,
        xi.jsa.CHAINSPELL,
        xi.jsa.PERFECT_DODGE, -- no combo
        xi.jsa.INVINCIBLE,
        xi.jsa.BLOOD_WEAPON, -- no combo
        xi.jsa.SOUL_VOICE,
        xi.jsa.MEIKYO_SHISUI,
        xi.jsa.MIJIN_GAKURE,
        xi.jsa.EES_AERN,
        xi.jsa.CALL_WYVERN,
        xi.jsa.FAMILIAR,
        xi.jsa.ASTRAL_FLOW,
    }

    xi.av.braceletsps =
    {
        xi.jsa.CHAINSPELL,
        xi.jsa.MIGHTY_STRIKES,
        xi.jsa.MEIKYO_SHISUI,
        xi.jsa.INVINCIBLE,
        xi.jsa.CALL_WYVERN,
    }

    -- Special check for regen modification by JoL pets killed
    local jol = GetMobByID(ID.mob.JAILER_OF_LOVE)
    if jol:getLocalVar('JoL_Qn_xzomit_Killed') == 9 then
        mob:addMod(xi.mod.REGEN, 125)
    end

    if jol:getLocalVar('JoL_Qn_hpemde_Killed') == 9 then
        mob:addMod(xi.mod.REGEN, 125)
    end

    -- base regen by day/element
    mob:addMod(xi.mod.REGEN, 250)

    --[[
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setLocalVar('dmgThreshold', 90)
    ]]--
end

entity.onMobRoam = function(mob)
end

entity.onMobEngaged = function(mob, target)
    xi.av.nextsp = os.time() + math.random(45, 90)
end

entity.onPlayerAbilityUse = function(mob, player, ability)
    debug(string.format('%s used ability: %s', player:getName(), ability:getName()))
    local abilityID = ability:getID()
    local sp = playerAbilityToMobSP[abilityID]
    if sp ~= nil and player:checkDistance(mob) <= 15 then
        local now = os.time()
        local used = mob:getLocalVar(string.format('sp_%u', sp))
        local lockWindowTime = 3 -- Just over 1x game tick
        if used ~= 0 and now < used + lockWindowTime then
            debug(string.format('%s used within lock window, trying to lock!', ability:getName()))
            entity.lock(sp)
        end
    end
end

-- TODO: make AV and JoL pets link to mobs current target when idle
entity.onMobFight = function(mob)
    entity.handleDamageResists(mob) -- damage taken scales with HP
    entity.handleSP(mob) -- AV has complex special ability logic

    if not xi.av.bracelets and mob:getHPP() <= 60 then
        mob:queue(0, function(mobArg)
            mobArg:setAnimationSub(2)
            mobArg:stun(2000)

            mobArg:addMod(xi.mod.STR, 50)
            mobArg:addMod(xi.mod.DEX, 50)
            mobArg:addMod(xi.mod.VIT, 50)
            mobArg:addMod(xi.mod.AGI, 50)
            mobArg:addMod(xi.mod.INT, 50)
            mobArg:addMod(xi.mod.MND, 50)
            mobArg:addMod(xi.mod.CHR, 50)
            mobArg:addMod(xi.mod.ATT, 300)
            mobArg:addMod(xi.mod.MATT, 50)

            xi.av.bracelets = true
        end)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then -- Meteor
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280) -- AoE Meteor Animation
    end
end

entity.onMagicHit = function(caster, target, spell)
    if
        spell:getSkillType() == xi.skill.ELEMENTAL_MAGIC and
        xi.av.regen >= 2 and xi.av.regen <= 48
    then
        local isCasterPCOrPet = caster:isPC() or caster:isPet()
        if
            VanadielDayElement() == spell:getElement() and
            isCasterPCOrPet
        then
            xi.av.regen = xi.av.regen - 2
            target:delMod(xi.mod.REGEN, 2)
        else
            xi.av.regen = xi.av.regen + 2
            target:addMod(xi.mod.REGEN, 2)
        end
    end

    return 1
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VIRTUOUS_SAINT)

    local firstCall = optParams.isKiller or optParams.noKiller
    if firstCall then
        local mobid = mob:getID()
        for i = 1, 6 do
            DespawnMob(mobid + i)
        end
    end
end

entity.onMobDespawn = function(mob)
    local mobid = mob:getID()
    for i = 1, 6 do
        DespawnMob(mobid + i)
    end
end

return entity
