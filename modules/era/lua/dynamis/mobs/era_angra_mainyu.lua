-----------------------------------
-- Angra Mainyu Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_angra_mainyu")

m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobSpawn", function(mob)
    local mobID = mob:getID()
    xi.dynamis.setMegaBossStats(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)

    xi.mix.jobSpecial.config(mob, {
        between = 300,
        specials =
        {
            {id = xi.jsa.CHAINSPELL, hpp = 25},
        },
    })
end)

m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobEngaged", function(mob, target)
    local OMobIndex = mobIndex
    local oMob = mob
    local i = 1
    local pets =
    {
        ["Fire Puki"] = {"4650756b" , 130, 134, 0, nil, nil}, -- FPuk
        ["Wind Puki"] = {"5750756b" , 130, 134, 0, nil, nil}, -- WPuk
        ["Poison Puki"] = {"506f50756b" , 130, 134, 0, nil, nil}, -- PoPuk
        ["Petro Puki"] = {"506550756b" , 130, 134, 0, nil, nil}, -- PePuk
    }
    for _, pet in pairs(pets) do
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = nameObj[1],
            x = oMob:getXPos()+math.random()*6-3,
            y = oMob:getYPos()-0.3,
            z = oMob:getXPos()+math.random()*6-3,
            rotation = oMob:getRotPos(),
            groupId = nameObj[2],
            groupZoneId = nameObj[3],
            onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end,
            onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
            onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
            onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
            onMobDeath = function(mob, playerArg, isKiller)
                xi.dynamis.mobOnDeath(mob, mobList[mob:getZoneID()], zones[mob:getZoneID()].text.DYNAMIS_TIME_EXTEND)
            end,
        })
        mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
        mob:setDropID(nameObj[4])
        if nameObj[5] ~= nil then -- If SpellList ~= nil set SpellList
            mob:setSpellList(nameObj[5])
        end
        if nameObj[6] ~= nil then -- If SkillList ~= nil set SkillList
            mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[6])
        end
        oMob:setLocalVar(string.format("PetID_%i", i + 1), mob:getID())
        mob:setLocalVar("PetMaster", OMobIndex)
        mob:spawn()
        mob:updateEnmity(target)
    end
end)

m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobFight", function(mob, target)
    local teles =
            {
            {279.4038, 20, 535.4518},
            {312.6868, 20.5267, 511.9843},
            {322.2653, 20, 481.8030},
            {295.9948, 20.7949, 483.1078},
            {269.6127, 19.5547, 505.3206},
            {240.9685, 20, 521.5283},
            {239.8057, 20.1687, 487.3961},
            {258.6785, 20.1525, 460.4170},
            }
        
        
            local teleTime = mob:getLocalVar("teleTime")
            if mob:getBattleTime() - teleTime > 30 then
                randPos = teles[math.random((1), (8))]
                xi.dynamis.teleport(mob, 1000)
                mob:setPos(randPos, 0)
                for i = 1, 4 do
                    local pet = GetMobByID(mob:getLocalVar(string.format("PetID_%i", i)))
                    if pet:isAlive() and mob:getHPP() <= 99 then
                        pet:disengage()
                        pet:resetEnmity(target)
                        pet:updateEnmity(mob:getTarget())
                    end
                end
                mob:setLocalVar("teleTime", mob:getBattleTime())
            end
        
            for i = 1, 4 do
                local pet = GetMobByID(mob:getLocalVar(string.format("PetID_%i", i)))
                if pet:isAlive() and pet:getCurrentAction() == xi.act.ROAMING then
                    pet:updateEnmity(target)
                end
            end
end)

m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobMagicPrepare", function(mob, target)
    if mob:getHPP() <= 25 then
        return 367 -- Death
    else
        -- Can cast Blindga, Death, Graviga, Silencega, and Sleepga II.
        -- Casts Graviga every time before he teleports.
        local rnd = math.random()

        if rnd < 0.2 then
            return 361 -- Blindga
        elseif rnd < 0.4 then
            return 367 -- Death
        elseif rnd < 0.6 then
            return 366 -- Graviga
        elseif rnd < 0.8 then
            return 274 -- Sleepga II
        else
            return 359 -- Silencega
        end
    end
end)

m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) mob:setLocalVar("teleTime", 0) end)
m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)
m:addOverride("xi.zones.Dynamis-Beaucedine.mobs.Angra_Mainyu.onMobDeath", function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, isKiller) end)

return m