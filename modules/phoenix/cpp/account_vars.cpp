/************************************************************************
 * Account Variables Module
 *
 * This module extends CLuaBaseEntity with account-wide variable methods
 * similar to how char_vars work but at the account level instead of character level.
 *
 * Methods provided:
 * - player:getAccountVar(varname) - Get an account variable value
 * - player:setAccountVar(varname, value, expiry) - Set an account variable (value 0 = delete)
 ************************************************************************/

#include "common/database.h"
#include "common/logging.h"
#include "common/vana_time.h"
#include "map/entities/char_entity.h"
#include "map/lua/luautils.h"
#include "map/utils/moduleutils.h"

class AccountVarsModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        // Startup cleanup of expired account variables
        uint32 currentTimestamp = earth_time::timestamp();
        db::preparedStmt("DELETE FROM account_vars WHERE expiry > 0 AND expiry <= ?", currentTimestamp);

        // Extend CLuaBaseEntity with account variable methods
        sol::usertype<CLuaBaseEntity> baseEntityType = ::lua["CBaseEntity"];

        baseEntityType["getAccountVar"] = [](CLuaBaseEntity* PLuaBaseEntity, std::string varname) -> int32
        {
            if (auto PChar = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity()))
            {
                uint32 accountId = PChar->accid;

                const auto rset = db::preparedStmt(
                    "SELECT value, expiry FROM account_vars WHERE accountid = ? AND varname = ? LIMIT 1",
                    accountId,
                    varname);

                int32  value  = 0;
                uint32 expiry = 0;

                if (rset && rset->rowsCount() && rset->next())
                {
                    value  = rset->get<int32>(0);
                    expiry = rset->get<uint32>(1);

                    // If expired, delete the variable and return 0
                    if (expiry > 0 && expiry <= earth_time::timestamp())
                    {
                        value = 0;
                        db::preparedStmt("DELETE FROM account_vars WHERE accountid = ? AND varname = ?", accountId, varname);
                    }
                }

                return value;
            }

            return 0;
        };

        // Register setAccountVar method: player:setAccountVar(varname, value, expiry)
        // Notes: Passing a '0' value will delete the variable
        baseEntityType["setAccountVar"] = [](CLuaBaseEntity* PLuaBaseEntity, std::string varname, int32 value, const sol::object& expiry) -> void
        {
            if (auto PChar = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity()))
            {
                uint32 accountId   = PChar->accid;
                uint32 expiryValue = 0;

                // Handle optional expiry parameter
                if (expiry.is<uint32>())
                {
                    expiryValue = expiry.as<uint32>();
                }

                // Validate expiry timestamp
                if (expiryValue > 0 && expiryValue <= earth_time::timestamp())
                {
                    ShowWarning(fmt::format("Attempting to set account variable '{}' with an expired time: {}", varname, expiryValue));
                    return;
                }

                // If value is 0, delete the variable
                if (value == 0)
                {
                    db::preparedStmt("DELETE FROM account_vars WHERE accountid = ? AND varname = ? LIMIT 1", accountId, varname);
                }
                else
                {
                    // Insert or update the account variable
                    db::preparedStmt(
                        "INSERT INTO account_vars SET accountid = ?, varname = ?, value = ?, expiry = ? "
                        "ON DUPLICATE KEY UPDATE value = ?, expiry = ?",
                        accountId,
                        varname,
                        value,
                        expiryValue,
                        value,
                        expiryValue);
                }
            }
        };
    }
};

REGISTER_CPP_MODULE(AccountVarsModule);
