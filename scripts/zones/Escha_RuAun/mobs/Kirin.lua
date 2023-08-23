-----------------------------------
-- Area: Sky 2.0
-- NM: Kirin
-- !spawnmob 17961571
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

local byakko = 17961580
local genbu  = 17961583
local seiryu = 17961586
local suzaku = 17961589

local pets =
{
    byakko,
    genbu,
    seiryu,
    suzaku
}

local kirinTwoHours =
{
    688,
    690,
    693,
    694,
    695,
    735,
    730
}

local playerTwoHours =
{
    16,
    17,
    21,
    22,
    23,
    27
}

local cantUse2Hr =
{
    "KIRIN_CANT_USE_MIGHTY_STRIKES",
    "KIRIN_CANT_USE_HUNDRED_FISTS",
    "KIRIN_CANT_USE_PERFECT_DODGE",
    "KIRIN_CANT_USE_INVINCIBLE",
    "KIRIN_CANT_USE_BLOOD_WEAPON",
    "KIRIN_CANT_USE_EES",
    "KIRIN_CANT_USE_MEIKYO",
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_MEVA, 65)
    mob:setMod(xi.mod.LULLABYRES, 9999)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.PETRIFYRES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.CHARMRES, 10000)
    mob:setMod(xi.mod.PARALYZERES, 10000)
    mob:setMod(xi.mod.STUNRES, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.DEF, 200)
    mob:setMod(xi.mod.EVA, 200)
    mob:setMod(xi.mod.MDEF, 200)
    mob:addMod(xi.mod.FASTCAST, 65)
    mob:setMod(xi.mod.MOVE, 50)
    mob:addMod(xi.mod.ATT, 150)
    mob:addMod(xi.mod.ACC, 100)
    mob:addMod(xi.mod.MACC, 250)
    mob:addMod(xi.mod.REFRESH, 25)
    mob:setUntargetable(false)
    mob:setDropID(0)

    mob:addListener("ATTACKED", "KIRIN_2HR_LISTENER", function(mobArg, targetArg)
        local enmityList = mobArg:getEnmityList()

        for i, v in ipairs(enmityList) do
            local playerName = {}
            playerName[i] = v.entity:getName()

            if (v.entity:getLocalVar("KIRIN_Listener") == 0 or v.entity:getLocalVar("KIRIN_Listener") == nil) then
                v.entity:addListener("ABILITY_STATE_EXIT", "PLAYER_USE_2HRS", function(playerArg, abilityArg)
                    local abilityID = abilityArg:getID()
                    local kirinUsedTwoHour = GetServerVariable("KIRIN_2HR_USED")
                    local kirinTwoHourTime = GetServerVariable("KIRIN_2HR_USED_TIME")

                    for n = 1, 7 do
                        if (abilityID == playerTwoHours[n] and playerArg:hasRecast(xi.recast.ABILITY, 0) and kirinUsedTwoHour == v and os.time() - kirinTwoHourTime <= 15) then
                            SetServerVariable(cantUse2Hr[n], 1)
                            if (abilityID == 16 and mobArg:hasStatusEffect(xi.effect.MIGHTY_STRIKES)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.MIGHTY_STRIKES)
                            elseif (abilityID == 17 and mobArg:hasStatusEffect(xi.effect.HUNDRED_FISTS)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.HUNDRED_FISTS)
                            elseif (abilityID == 21 and mobArg:hasStatusEffect(xi.effect.PERFECT_DODGE)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.PERFECT_DODGE)
                            elseif (abilityID == 22 and mobArg:hasStatusEffect(xi.effect.INVINCIBLE)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.INVINCIBLE)
                            elseif (abilityID == 23 and mobArg:hasStatusEffect(xi.effect.BLOOD_WEAPON)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.BLOOD_WEAPON)
                            elseif (abilityID == 27 and mobArg:hasStatusEffect(xi.effect.MEIKYO_SHISUI)) then
                                mobArg:weaknessTrigger(3)
                                mobArg:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mobArg:delStatusEffect(xi.effect.MEIKYO_SHISUI)

                            end
                        end
                    end
                end)

                v.entity:setLocalVar("KIRIN_Listener", 1)
            end
        end
    end)
end

entity.onMobFight = function(mob, target)

    local kouryu = 17961577

    if mob:getHPP() < 50 then
        mob:setHP(0)
        GetMobByID(kouryu):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(kouryu):updateClaim(mob:getTarget())
    end

    if mob:getLocalVar("gods") == 0 and mob:getHPP() <= 90 then
        GetMobByID(byakko):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(byakko):updateEnmity(mob:getTarget())
        mob:setLocalVar("gods", 1) -- prevent repop
    elseif mob:getLocalVar("gods") == 1 and mob:getHPP() <= 80 then
        GetMobByID(seiryu):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(seiryu):updateEnmity(mob:getTarget())
        mob:setLocalVar("gods", 2) -- prevent repop
    elseif mob:getLocalVar("gods") == 2 and mob:getHPP() <= 70 then
        GetMobByID(suzaku):setSpawn(mob:getXPos() + 6, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(suzaku):updateEnmity(mob:getTarget())
        mob:setLocalVar("gods", 3) -- prevent repop
    elseif mob:getLocalVar("gods") == 3 and mob:getHPP() <= 60 then
        GetMobByID(genbu):setSpawn(mob:getXPos() + 8, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(genbu):updateEnmity(mob:getTarget())
        mob:setLocalVar("gods", 4) -- prevent repop
    end

    mob:addListener("MAGIC_TAKE", "KIRIN_REFLECT", function(targetArg1, caster, spell)
    if
        spell:tookEffect() and
        (caster:isPC() or caster:isPet()) and
        (spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE or targetArg1:getLocalVar("[kirim]reflect_blue_magic") == 1)
    then
        targetArg1:setLocalVar("[kirin]spellToMimic", spell:getID())
        targetArg1:setLocalVar("[kirin]castWindow", os.time() + 30)
        targetArg1:setLocalVar("[kirin]castTime", os.time() + 6)
    end
    end)

    mob:addListener("COMBAT_TICK", "KIRIN_REFLECT_CTICK", function(kirin)
    local spellToMimic = kirin:getLocalVar("[kirin]spellToMimic")
    local castWindow = kirin:getLocalVar("[kirin]castWindow")
    local castTime = kirin:getLocalVar("[kirin]castTime")
    local osTime = os.time()

        if spellToMimic > 0 and osTime > castTime and castWindow > osTime and not kirin:hasStatusEffect(xi.effect.SILENCE) then
            kirin:castSpell(spellToMimic, target)
            kirin:setLocalVar("[kirin]spellToMimic", 0)
            kirin:setLocalVar("[kirin]castWindow", 0)
            kirin:setLocalVar("[kirin]castTime", 0)
        elseif spellToMimic == 0 or osTime > castWindow then
            kirin:setLocalVar("[kirin]spellToMimic", 0)
            kirin:setLocalVar("[kirin]castWindow", 0)
            kirin:setLocalVar("[kirin]castTime", 0)
        end
    end)

    mob:addListener("DISENGAGE", "KIRIN_DISENGAGE", function(kirinArg)
        kirinArg:setLocalVar("[kirin]spellToMimic", 0)
        kirinArg:setLocalVar("[kirin]castWindow", 0)
        kirinArg:setLocalVar("[kirin]castTime", 0)
    end)

    for i = 1, 4 do
        local god = GetMobByID(pets[i])
           if (god:getCurrentAction() == xi.act.ROAMING) then
           god:updateEnmity(target)
        end
    end
-----------------------------------
--         2 HR LOGIC            --
-----------------------------------
    local isBusy = false
    local act = mob:getCurrentAction()
    local twoHoursLocked = {}
    local next2HrTime = GetServerVariable("KIRIN_NEXT_2HR_TIME")

    if act == xi.act.MOBABILITY_START then
        isBusy = true
    elseif act == xi.act.MOBABILITY_USING then
        isBusy = true
    elseif act == xi.act.MOBABILITY_FINISH then
        isBusy = true
    elseif act == xi.act.MAGIC_START then
        isBusy = true
    elseif act == xi.act.MAGIC_CASTING then
        isBusy = true
    end

    for i = 1, 7 do
        if (GetServerVariable(cantUse2Hr[i]) == 1) then
            table.insert(twoHoursLocked, i)
        end
    end

    if (mob:getBattleTime() >= 90 and os.time() >= next2HrTime and isBusy == false and #twoHoursLocked ~= 7) then
        local pick2Hr = math.random(1, 7)
        if (GetServerVariable(cantUse2Hr[pick2Hr]) == 0) then
            if (pick2Hr > 0 and pick2Hr < 6) then
                mob:useMobAbility(kirinTwoHours[pick2Hr])
            elseif (pick2Hr == 7) then
                mob:useMobAbility(kirinTwoHours[pick2Hr])
                for i = 1, 3 do
                    local meikyoRandom = math.random(1, 100)
                    if (meikyoRandom < 50) then
                        mob:useMobAbility(797) -- Deadly Hold
                    else
                        mob:useMobAbility(803) -- Great Whirlwind
                    end
                end
            end

            SetServerVariable("KIRIN_2HR_USED", pick2Hr)
            SetServerVariable("KIRIN_2HR_USED_TIME", os.time())
            SetServerVariable("KIRIN_NEXT_2HR_TIME", os.time() + math.random(60, 90))
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player)
    mob:removeListener("KIRIN_2HR_LISTENER")
    player:removeListener("PLAYER_USE_2HRS")
    player:setLocalVar("KIRIN_Listener", 0)
    SetServerVariable("KIRIN_2HR_USED", 0)
    SetServerVariable("KIRIN_2HR_USED_TIME", 0)
    SetServerVariable("KIRIN_NEXT_2HR_TIME", 0)

    for i = 1, 7 do
        SetServerVariable(cantUse2Hr[i], 0)
    end

    for i = 17961580, 17961580 + 9 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function( mob )
    for i = 17961580, 17961580 + 9 do
        DespawnMob(i)
    end
end

return entity
