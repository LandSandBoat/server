-----------------------------------
-- Area: Sky 2.0
-- NM: Kirin
-- !spawnmob 17961571
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/titles")
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")

local entity = {}

local byakko = 17961580
local genbu  = 17961583
local seiryu = 17961586
local suzaku = 17961589

-- pet gods
local pets =
    {
        byakko,
        genbu,
        seiryu,
        suzaku,
    }

local kirinTwoHours = {688, 690, 693, 694, 695, 735, 730}
local playerTwoHours = {16, 17, 21, 22, 23, 27}
local cantUse2Hr = {"KIRIN_CANT_USE_MIGHTY_STRIKES", "KIRIN_CANT_USE_HUNDRED_FISTS", "KIRIN_CANT_USE_PERFECT_DODGE",
                    "KIRIN_CANT_USE_INVINCIBLE", "KIRIN_CANT_USE_BLOOD_WEAPON", "KIRIN_CANT_USE_EES", "KIRIN_CANT_USE_MEIKYO",}

entity.onMobInitialize = function( mob )
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_MEVA, 65)
    mob:setMod(xi.mod.SILENCERES, 99)
    mob:setMod(xi.mod.SLEEPRES, 85)
    mob:setMod(xi.mod.PETRIFYRES, 95)
    mob:setMod(xi.mod.BINDRES, 85)
    mob:setMod(xi.mod.CHARMRES, 100)
    mob:setMod(xi.mod.DEATHRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 20)
    mob:setMod(xi.mod.STUNRES, 100)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.GRAVITYRES, 30)
    mob:addMod(xi.mod.DEF, 100)
    mob:addMod(xi.mod.FASTCAST, 65)
    mob:setMod(xi.mod.MOVE, 50)
    mob:addMod(xi.mod.ATT, 250)
    mob:addMod(xi.mod.ACC, 100)
    mob:addMod(xi.mod.MACC, 250)
    mob:addMod(xi.mod.REFRESH, 25)
    mob:setUntargetable(false)
    mob:setDropID(0)

    mob:addListener("ATTACKED", "KIRIN_2HR_LISTENER", function(mob, target)
        -- Get all players on the mob's enmity list
        local enmityList = mob:getEnmityList()
        local PlayerName = {}

        -- Use the enmity list to create listeners for players using 2hr abilities
        for i, v in ipairs(enmityList) do
            PlayerName[i] = v.entity:getName()

            if (v.entity:getLocalVar("KIRIN_Listener") == 0 or v.entity:getLocalVar("KIRIN_Listener") == nil) then
                v.entity:addListener("ABILITY_STATE_EXIT", "PLAYER_USE_2HRS", function(player, ability)
                    local abilityID = ability:getID()
                    local abilityRecast = ability:getRecast()
                    local kirinUsedTwoHour = GetServerVariable("KIRIN_2HR_USED")
                    local kirinTwoHourTime = GetServerVariable("KIRIN_2HR_USED_TIME")

                    for v = 1, 6 do
                        if (abilityID == playerTwoHours[v] and player:hasRecast(xi.recast.ABILITY, 0) and kirinUsedTwoHour == v and os.time() - kirinTwoHourTime <= 15) then
                            SetServerVariable(cantUse2Hr[v], 1)

                            if (abilityID == 16 and mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.MIGHTY_STRIKES)
                            elseif (abilityID == 17 and mob:hasStatusEffect(xi.effect.HUNDRED_FISTS)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.HUNDRED_FISTS)
                            elseif (abilityID == 21 and mob:hasStatusEffect(xi.effect.PERFECT_DODGE)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.PERFECT_DODGE)
                            elseif (abilityID == 22 and mob:hasStatusEffect(xi.effect.INVINCIBLE)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.INVINCIBLE)
                            elseif (abilityID == 23 and mob:hasStatusEffect(xi.effect.BLOOD_WEAPON)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.BLOOD_WEAPON)
                            elseif (abilityID == 27 and mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI)) then
                                mob:weaknessTrigger(3)
                                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
                                mob:delStatusEffect(xi.effect.MEIKYO_SHISUI)

                            end
                        end
                    end
                end)

                v.entity:setLocalVar("KIRIN_Listener", 1)
            end
        end
    end)
end

entity.onMobFight = function( mob, target )
-- Upgrade
    local kouryu = 17961577

-- Turn over to Kouryu
    if mob:getHPP() < 50 then
        DespawnMob(mob:getID())
        GetMobByID(kouryu):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(kouryu):updateClaim(mob:getTarget())
    end

-- GOD logic
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
-- END God logic

-- KIRIN REFLECT LOGIC
    mob:addListener("MAGIC_TAKE", "KIRIN_REFLECT", function(target, caster, spell)
    if
        spell:tookEffect() and
        (caster:isPC() or caster:isPet()) and
        (spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE or target:getLocalVar("[kirim]reflect_blue_magic") == 1)
    then
        target:setLocalVar("[kirin]spellToMimic", spell:getID()) -- which spell to mimic
        target:setLocalVar("[kirin]castWindow", os.time() + 30) -- after thirty seconds, will stop attempting to mimic
        target:setLocalVar("[kirin]castTime", os.time() + 6) -- enforce a delay between original spell, and mimic spell.
    end
    end)

    mob:addListener("COMBAT_TICK", "KIRIN_REFLECT_CTICK", function(mob)
        local spellToMimic = mob:getLocalVar("[kirin]spellToMimic")
        local castWindow = mob:getLocalVar("[kirin]castWindow")
        local castTime = mob:getLocalVar("[kirin]castTime")
        local osTime = os.time()

            if spellToMimic > 0 and osTime > castTime and castWindow > osTime and not mob:hasStatusEffect(xi.effect.SILENCE) then
                mob:castSpell(spellToMimic, target)
                mob:setLocalVar("[kirin]spellToMimic", 0)
                mob:setLocalVar("[kirin]castWindow", 0)
                mob:setLocalVar("[kirin]castTime", 0)
                target:PrintToArea(string.format("Kirin: TAKE SOME MAGIC %s!", target:getName()), xi.msg.area.SYSM_1);
            elseif spellToMimic == 0 or osTime > castWindow then
                mob:setLocalVar("[kirin]spellToMimic", 0)
                mob:setLocalVar("[kirin]castWindow", 0)
                mob:setLocalVar("[kirin]castTime", 0)
        end
    end)

    mob:addListener("DISENGAGE", "KIRIN_DISENGAGE", function(mob)
        mob:setLocalVar("[kirin]spellToMimic", 0)
        mob:setLocalVar("[kirin]castWindow", 0)
        mob:setLocalVar("[kirin]castTime", 0)
    end)
-- END REFLECT LOGIC
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

    if act == xi.act.MOBABILITY_START or act == xi.act.MOBABILITY_USING or act == xi.act.MOBABILITY_FINISH or act == xi.act.MAGIC_START
       or act == xi.act.MAGIC_CASTING or act == xi.act.MAGIC_START then
        isBusy = true -- Set to true if AV is in any stage of using a mobskill or casting a spell
    end

    -- Build the twoHoursLocked table to check against and reduce script spam once all two hours have been locked
    for i = 1, 7 do
        if (GetServerVariable(cantUse2Hr[i]) == 1) then
            table.insert(twoHoursLocked, i)
        end
    end

    -- Uses a 2hr every 45-90 seconds
    if (mob:getBattleTime() >= 90 and os.time() >= next2HrTime and isBusy == false and #twoHoursLocked ~= 7) then
        local pick2Hr = math.random(1, 7)

        if (GetServerVariable(cantUse2Hr[pick2Hr]) == 0) then
            if (pick2Hr > 0 and pick2Hr < 6) then
                mob:useMobAbility(kirinTwoHours[pick2Hr])
            elseif (pick2Hr == 7) then
                mob:useMobAbility(kirinTwoHours[pick2Hr])
                for i = 1, 5 do
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
            SetServerVariable("KIRIN_NEXT_2HR_TIME", os.time() + math.random(45, 90))
        end
    end

    if (mob:getHPP() <= 60 and mob:getLocalVar("KIRIN_RAGE") == 1) then
        mob:setLocalVar("KIRIN_RAGE", 1)

        mob:setMod(xi.mod.DMG, -50)
        mob:setMod(xi.mod.ATT, 150)
        mob:setMod(xi.mod.ACC, 150)
        mob:setMod(xi.mod.MACC, 150)
        mob:setMod(xi.mod.MEVA, 50)
        mob:setMod(xi.mod.DEF, 150)
        mob:setMod(xi.mod.MATT, 25)
        target:PrintToArea(string.format("Kirin: FUCK YOU %s!", target:getName()), xi.msg.area.SYSM_1);
      printf("Kirin.lua onMobFight RAGE")
    end

    if mob:getLocalVar("KIRIN_RAGE") == 1 then
        local resonance = mob:getStatusEffect(xi.effect.SKILLCHAIN)
        if (resonance ~= nil and resonance:getTier() > 2) then
            mob:addStatusEffect(xi.effect.TERROR, 0, 0, 15)
            mob:weaknessTrigger(2)
            mob:setMod(xi.mod.DMG, -250)
            mob:setMod(xi.mod.ATT, 0)
            mob:setMod(xi.mod.ACC, 0)
            mob:setMod(xi.mod.MACC, 0)
            mob:setMod(xi.mod.MEVA, 0)
            mob:setMod(xi.mod.DEF, 0)
            mob:setMod(xi.mod.MATT, 0)
            mob:setLocalVar("KIRIN_RAGE", 2) -- prevent Rage
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player)
    -- Clean up listeners and variables
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

    for _, partyMember in pairs(player:getAlliance()) do
        partyMember:addKeyItem(xi.keyItem.KIRINS_FERVOR)
        partyMember:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.KIRINS_FERVOR)
    end
end

entity.onMobDespawn = function( mob )
    for i = 17961580, 17961580 + 9 do
        DespawnMob(i)
    end
end

return entity
