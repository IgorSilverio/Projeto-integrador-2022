IF object_id(N'[dbo].[FK_dbo.EnderecoPacientes_dbo.Cooperadas_Cooperada_idCooperada]', N'F') IS NOT NULL
    ALTER TABLE [dbo].[EnderecoPacientes] DROP CONSTRAINT [FK_dbo.EnderecoPacientes_dbo.Cooperadas_Cooperada_idCooperada]
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Cooperada_idCooperada' AND object_id = object_id(N'[dbo].[EnderecoPacientes]', N'U'))
    DROP INDEX [IX_Cooperada_idCooperada] ON [dbo].[EnderecoPacientes]
CREATE TABLE [dbo].[EnderecoCooperadas] (
    [idEnderecoCooperada] [uniqueidentifier] NOT NULL,
    [cepEnderecoCooperada] [varchar](10),
    [numeroEnderecoCooperada] [int] NOT NULL,
    [estadoEnderecoCooperada] [varchar](50) NOT NULL,
    [logradouroEnderecoCooperada] [varchar](50) NOT NULL,
    [bairroEnderecoCooperada] [varchar](50) NOT NULL,
    [cidadeEnderecoCooperada] [varchar](50) NOT NULL,
    [complementoEnderecoCooperada] [varchar](100),
    [idCooperada] [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_dbo.EnderecoCooperadas] PRIMARY KEY ([idEnderecoCooperada])
)
ALTER TABLE [dbo].[Cooperadas] ADD [dtCadastroCooperada] [datetime] NOT NULL DEFAULT '1900-01-01T00:00:00.000'
CREATE INDEX [IX_idCooperada] ON [dbo].[EnderecoCooperadas]([idCooperada])
DECLARE @var0 nvarchar(128)
SELECT @var0 = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(N'dbo.Cooperadas')
AND col_name(parent_object_id, parent_column_id) = 'dtCadastroPaciente';
IF @var0 IS NOT NULL
    EXECUTE('ALTER TABLE [dbo].[Cooperadas] DROP CONSTRAINT [' + @var0 + ']')
ALTER TABLE [dbo].[Cooperadas] DROP COLUMN [dtCadastroPaciente]
DECLARE @var1 nvarchar(128)
SELECT @var1 = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(N'dbo.EnderecoPacientes')
AND col_name(parent_object_id, parent_column_id) = 'Cooperada_idCooperada';
IF @var1 IS NOT NULL
    EXECUTE('ALTER TABLE [dbo].[EnderecoPacientes] DROP CONSTRAINT [' + @var1 + ']')
ALTER TABLE [dbo].[EnderecoPacientes] DROP COLUMN [Cooperada_idCooperada]
ALTER TABLE [dbo].[EnderecoCooperadas] ADD CONSTRAINT [FK_dbo.EnderecoCooperadas_dbo.Cooperadas_idCooperada] FOREIGN KEY ([idCooperada]) REFERENCES [dbo].[Cooperadas] ([idCooperada])
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'202209151559442_AutomaticMigration', N'Almoxarifado.Infra.Data.Migrations.Configuration',  0x1F8B0800000000000400DD5C5B6FE344147E47E23F587E44A54EBA80A04A1695EC16556CDBD5A65DF1564DED493A608F8D3DAE5A10BF8C077E127F81E324BECDC59EB1279B82FAD2DAC7DF99CB39DFDCBEE93F7FFD3DFBFE290A9D479C6624A673777A3C711D4CFD3820743D7773B6FAF25BF7FBD79F7F367B1B444FCEC7D2EE5561075FD26CEE3E30969C7A5EE63FE00865C711F1D3388B57ECD88F230F05B17732997CE74DA71E060817B01C67F621A78C4478F307FCB988A98F1396A3F0320E7098ED9EC39BE506D5B94211CE12E4E3B97B1646F1134AC90AA08F2FE82A45C76F1043AE73161204C559E270E53A88D2982106853DBDCDF092A5315D2F137880C29BE70483DD0A8519DE55E2B436D7ADCFE4A4A88F577F5842F979C6E2C81070FA6AD7401EFFF9A06676AB0684267C0B4DCD9E8B5A6F9A71EE2EE238C1290AA0CD786FA78B302D2CB9667E0336841E6F9008CE8E2B842347627754C5098453F173E42CF290E5299E539CB3148547CEFBFC3E24FE4FF8F926FE15D339CDC3B059682836BC6B3D8047EFD3C22D7BFE8057BBAA90A05119AF0DE0F108D5F7B28FB7B5FE312781EB5C4169D07D88AB20F13A7152F43B8A05288839C821D7B9444FEF305DB387B9FB0D24CD3979C241F960077F4B09641C7CC3D21C1BBBA77184CF11652823E870A558857710418F71E9F887380E31A2C6383E4D7ED1A9C5C95E6A01A945421DF75FEBB9EFF616C5D0624B02BCE75BF46958658643BC8A29D62901FC6AA1DA015B809B0C3859F0094C8E6F6060E8AFC5157A24EB0D67F1015462BEA5014EB11F67AEF301871BD3EC8124DB11E2B87C5B15E1CEAF0B739EC6D187B870DE61767783D2356650F4B8DF7619E7A9CFD562E6D5D4DC49D802F060E216900E4FE092CA9913B9046404A1C35C440928C98AA90D2EA07984D358E9F682B25727E6749631E85593BAEC8763C2780D7E21055E4059EE11495F42397C12A000BF8072C45112E2085366D428D3898DA81F3C05EBA7FF7DB17EC9E43AAC5F8E10A358FF3DF209F40E1E4DFA25D0CBE1FC31543F96E13F0DA1DBE0EF03D2F581D8F940647C48EEFD04545B138915A64D2AB80EA22D7DDED5D622CD0A464A92152D4751EC686A7D39945A57C59C52870586641B82079205F37E32A9F0BE8C7D82428B65D0D82B4834BC69A6AF2977242B9DAA7EB50FDF01BB42994F36C4C517427F092FD90DD96E8668D4CB4A0FFA28659800F603D270B99F7DB372FBE5607DB90ACF6CECDBD59B3AC303A277A8D1DBD21938E6A8B673D4A393CE98739665052D154555EDE634D620EDF6004BC76041B28D1BE93207E208461E92C05803659CBB5F086DAFE7AB6AA3DA97D2C754F001E31520D3E21066013D072320A14C1CDC08F5498242FDE27010A6270545E7555EF9376F7082A10494E9F78485E2545EB9B1BCAF05675E23DEF4C250CC96BEC0E898AE892158B381790476E468ED48E5C072F829CBA2D7DBAAE9D9A0D85376C0F8B2580FBC2D2BC2370CBEC0E9AE10CDD972F10E3F31C91CFC36C3BB6978B61BDCF88829B09798F1079B303ED46C2CF29410786D1821C56570FDDBD62AD8B2F9BB5095B3791EB40B4C09D2E8AA8E5A37B7C61A5F68ECA4F15165368E555594F78410B3662357035D8DDA8A66B035683EC9E443DD783DDC6BC8BE92866B848746BBA9F9B601AD84EC68B4727254D1402DF0F0B60A8F5209E229A420B34B942430216E4843764F9CE55617B2F87269AE9588B6189E9F49241355692B4F2C4ED11A736F8B400AF0394933560851EE5131B35D04916026233D4576971E055E133BB14CFAF293E27791641B4A9906138AE3C50EE51CEA59ACEE3655C6B29C11BFDDA8755088D2AE3DFE451CE611D59803A9F178B94513927FA78FAA505134C11526FA3E6A8D4413B67EAA8FC4A9249A70DC2B7D4C5EFBD004E5DFE9A3CA350E4D6CB985BE078980A1092F79AD8F2D952A34D1A50622FECCE3124B98780989CC712B4F0D5AC421193F6D108838F73127120D0C35A148265F6D62E99D9D75E1CB8FFF5B3926B530201BD5617F8B6E54460629AD3AFF6FE5B6CA48DF4FE7F97ED357A7A1BE3FE5197ED397D2C820125467F4AD60501919F8E93C836F39EBB4D4F73874503E3091D5934F9B3CF65E31FB36A03135443F8BA9C8CB90B3048A326724190199F38D8C5E86B1898A3CCCB942460DE64C204BFC8179AE4C6BB32CAED7F8ED1852EFF11C2C87EDE6EE889C1D92AB43DAB96BA921C76BBF3143E44F3F795CFEBDE1C220910273AF0C32A1797AD9CA84E60B9389BAEC44B23D539759982D64F8E3497E19C3BF37680FD95164AB5D6406E68B2439B8F8D664517B265BD39E992E69650788F295D6C1B84DD8C6E24D2AEFD57616B76D35DB6D21F55F7312F694B626AE03CDF64882623F69F99C311C6DE970F95BB8088B56A90D2E11252B187DB7CA12F764323DE12E49BD9C0B4B5E9605E1F05B4B1730637A9ABB7F387FBE844B443925BFE59814A7286445706AE942D1234AFD07940A9A049BD7852CF9E02F03DD1366E72290AC7C27E6E5935FF391817FDD021F7BA9A7DFC3B82B3B32FC6F2713E33A74DCD00910C3AC5FCD61F56ECBD8F4DEEF1593D1E9DE75DD44D6A353E3FEECB95C42A8797AF65C2DB114E91A17472C79EAB91662C94BCFA50F5B5E34AE74C803CB38B2B4863F75421720A7CEC5CF770D9C23E73A85429F3A13C877CB2CD321F8B5453236EE34D8A0947D30C878C2D81B3FEC850EF692FDFB4B76EBB9CD4B3907A676AD92B79FD97BCC689B92FAD1192D93D74BFB794008A9C5F31A1E064BE535A274A810BE821662826C6362131A67F563E70FE722BBDDF4D1A97303352A0294935E5BD4C86B4EA2E58B0BB946DECEE2A543116FBD4D07AC2B556279692899771927851FB26A55CBE0472E9CECE8C8C59BBD8612EE0EB1DD5805FA20796E9704E1138AC0FFB79A6FE15A8A99E45AAD311C29161F142C1D67469F4CB3FDDFD1688BAA46C5319FB8415B5398C830DB7D6CE0C3FB8268B73CD8A1C4E5BD488845F026B19179ED5717F76AB8B524DC5DBED56A5ADE7587CB6E576A1787D3810BBDC7894B8D54DEDD92F1FF82B69BEFDBF631B58974BB5305BE1FC5B678A40554D4F8FF7E40891959D710C57FFBA3D86F91506573415771C9875C894A136EC6758919F432436729ACAC90CFE0B58FB36C7379F2230AF3A291A27B1C5CD0EB9C2539832AE3E83E7C6E3646C1A95DFE37B2F4769967D7C9E6FAA18D2A403149313DBCA63FE4240CAA729F4BA6870A8882AC7FC4F07CDB97C0FD0CAF9F2BA42B9834EB01ED9AAF1A636E70948400965DD3257AC443CA769BE177788DFCE7F264520DD2DF11ED669FBD21689DA228DB61D4DFC39F10C341F4F4FA5F585D5C43E6520000 , N'6.4.4')
