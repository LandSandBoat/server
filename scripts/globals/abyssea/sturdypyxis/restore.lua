-----------------------------------
-- Abyssea Sturdy Pyxis - Restore HP/MP/JA
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}
xi.pyxis.restore = {}

xi.pyxis.restore.giveRestore = function(npc, player)
    local alliance = player:getAlliance()
    local restore = npc:getLocalVar('RESTORE')

    switch(restore) : caseof
    {
        [1] = function()
            player:restoreFromChest(npc, 1)

            for p, member in ipairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    if member:isPC() then
                        member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, hp)
                    end
                end
            end
        end,

        [2] = function()
            player:restoreFromChest(npc, 2)

            for p, member in ipairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    member:addMP(mp)
                    if member:isPC() then
                        member:messageBasic(xi.msg.basic.RECOVERS_MP, 0, mp)
                    end
                end
            end
        end,

        [3] = function()
            player:restoreFromChest(npc, 1)

            for p, member in ipairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    member:addTP(1000)
                end
            end
        end,

        [4] = function()
            player:restoreFromChest(npc, 1)

            for p, member in ipairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    member:addMP(mp)
                    member:addTP(3000)
                    if member:isPC() then
                        member:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
                    end
                end
            end
        end,

        [5] = function()
            player:restoreFromChest(npc, 1)

            for p, member in ipairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    member:addMP(mp)
                    member:addTP(3000)
                    if member:isPC() then
                        member:resetRecasts()
                        member:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
                        member:messageBasic(xi.msg.basic.ALL_ABILITIES_RECHARGED)
                    end
                end
            end
        end,
    }
end
