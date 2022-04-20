#include "sql_prepared_stmt.h"

#include "logging.h"
#include "utils.h"

#include <vector>

SqlPreparedStatement::SqlPreparedStatement(MYSQL* handle, std::string const& query)
{
    m_Statement = mysql_stmt_init(handle);
    if (m_Statement == nullptr)
    {
        ShowError("mysql_stmt_init (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return;
    }

    auto res = mysql_stmt_prepare(m_Statement, query.c_str(), query.size());
    if (res != 0)
    {
        ShowError("mysql_stmt_prepare (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return;
    }

    std::size_t paramCount = mysql_stmt_param_count(m_Statement);
    std::size_t fieldCount = mysql_stmt_field_count(m_Statement);

    m_Params = std::vector<MYSQL_BIND>(paramCount);
    m_Fields = std::vector<MYSQL_BIND>(fieldCount);

    ShowInfo("Params: %i, Fields: %i", paramCount, fieldCount);
}

SqlPreparedStatement::~SqlPreparedStatement()
{
    mysql_stmt_close(m_Statement);
}

int32 SqlPreparedStatement::Execute(MYSQL* handle, uint32 id, std::string varname)
{
    // TODO: Handle this with a parameter pack
    m_Params[0].buffer_type = MYSQL_TYPE_LONG;
    m_Params[0].buffer = &id;
    unsigned long bl1 = sizeof(id);
    m_Params[0].buffer_length = bl1;
    m_Params[0].is_null = 0;
    unsigned long tl1 = sizeof(id);
    m_Params[0].length = &tl1;

    m_Params[1].buffer_type = MYSQL_TYPE_STRING;
    m_Params[1].buffer = (char*)varname.c_str();
    unsigned long bl2 = varname.size();
    m_Params[1].buffer_length = bl2;;
    m_Params[1].is_null = 0;
    unsigned long tl2 = varname.size();
    m_Params[1].length = &tl2;

    if (mysql_stmt_bind_param(m_Statement, m_Params.data()) != 0)
    {
        ShowError("mysql_stmt_bind_param (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return 0;
    }

    if (mysql_stmt_execute(m_Statement) != 0)
    {
        ShowError("mysql_stmt_execute (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return 0;
    }

    // TODO: This can all be handled dynamically
    MYSQL_BIND result[1];

    // Release the result on the way out of this function
    ScopeGuard sg([&](){ mysql_stmt_free_result(m_Statement); });

    unsigned long resultLength[1];
    int32 out = 0;

    result[0].buffer = &out;
    result[0].buffer_type = MYSQL_TYPE_LONG;
    result[0].length = &resultLength[0];

    if (mysql_stmt_bind_result(m_Statement, result) != 0)
    {
        ShowError("mysql_stmt_bind_result (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return 0;
    }

    if (mysql_stmt_fetch(m_Statement) != 0)
    {
        ShowError("mysql_stmt_fetch (%i): %s", mysql_stmt_errno(m_Statement), mysql_stmt_error(m_Statement));
        return 0;
    }

    return out;
}
