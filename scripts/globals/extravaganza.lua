-----------------------------------
-- Alter Ego Extravaganza
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.extravaganza = {}

xi.extravaganza.campaign =
{
    NONE        =   0,
    SUMMER_NY   =   1,
    SPRING_FALL =   2,
    BOTH        =   3,
}

xi.extravaganza.campaignActive = function()
    return xi.settings.main.ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA
end

-----------------------------------
-- Determine Which Ciphers to Grant by NPC Name
-----------------------------------

xi.extravaganza.getShadowEraCiphers = function(npc)
    local cipherNpcs =
    {
        ['Shixo']   =   { xi.item.CIPHER_OF_NOILLURIES_ALTER_EGO, xi.item.CIPHER_OF_LEONOYNES_ALTER_EGO },
        ['Shenni']  =   { xi.item.CIPHER_OF_ELIVIRAS_ALTER_EGO, xi.item.CIPHER_OF_MAXIMILIANS_ALTER_EGO },
        ['Shuvo']   =   { xi.item.CIPHER_OF_LHUS_ALTER_EGO, xi.item.CIPHER_OF_KAYEELS_ALTER_EGO },
    }
    return cipherNpcs[npc:getName()]
end

-----------------------------------
-- Check if Extravaganza is active, hide [S] vendors if inactive
-----------------------------------

xi.extravaganza.shadowEraHide = function(npc)
    local active = xi.extravaganza.campaignActive()

    if
        active == xi.extravaganza.campaign.NONE or
        active == xi.extravaganza.campaign.SPRING_FALL
    then
        GetNPCByID(npc):setStatus(xi.status.DISAPPEAR)
    end
end

-----------------------------------
-- Check if Extravaganza is Active, set Ciphers, Launch CS
-----------------------------------

xi.extravaganza.shadowEraTrigger = function(player, npc, notes)
    local active = xi.extravaganza.campaignActive()
    if
        active == xi.extravaganza.campaign.SUMMER_NY or
        active == xi.extravaganza.campaign.BOTH
    then
        local cipherids = xi.extravaganza.getShadowEraCiphers(npc)
        player:setLocalVar('ShadowCipher1', cipherids[1])
        player:setLocalVar('ShadowCipher2', cipherids[2])
        player:startEvent(7300, 0, notes, 6)
    end
end

-----------------------------------
-- Pull Cipher IDs out of local vars between functions
-- Choose the right cipher depending on Menu Option
-----------------------------------

xi.extravaganza.shadowEraFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    local notes = player:getCurrency('allied_notes')
    local cipherid = { player:getLocalVar('ShadowCipher1'), player:getLocalVar('ShadowCipher2') }
    local choice = 0

    if csid == 7300 then -- All 3 Shadow Era Cipher vendors share the same CSID and options
        if option == 65537 then -- First Cipher
            choice = 1
        elseif option == 131073 then -- Second Cipher
            choice = 2
        end

        if option == 65537 or option == 131073 then
            if notes >= 1000 then
                if npcUtil.giveItem(player, cipherid[choice]) then
                    player:delCurrency('allied_notes', 1000)
                end
            elseif notes < 1000 then
                player:messageSpecial(ID.text.NOT_ENOUGH_NOTES)
            end
        end
    end
end
