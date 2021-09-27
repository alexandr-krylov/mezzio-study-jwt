-- Adminer 4.7.7 PostgreSQL dump

-- \connect B2BCabinet;

DROP TABLE IF EXISTS Country CASCADE;
CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    country character varying(255),                     -- страна
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS IdentAutority CASCADE;
CREATE TABLE IdentAutority (
    id SERIAL PRIMARY KEY,
    identAutority character varying(255),               -- орган выдавший документ удостоверяющий личность
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS PaymentType CASCADE;
CREATE TABLE PaymentType (
    id SERIAL PRIMARY KEY,
    paymentType character varying(255),                 -- тип платежа
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS PowerAttorneyType CASCADE;
CREATE TABLE PowerAttorneyType (
    id SERIAL PRIMARY KEY,
    powerAttorneyType character varying(255),           -- Вид доверенности на представителя
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS LegalEntityType CASCADE;
CREATE TABLE LegalEntityType (
    id SERIAL PRIMARY KEY,                              -- PRIMARY KEY
    legalEntityType character varying(255) NOT NULL,    -- Тип юридического лица (ИП)
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS IdentType CASCADE;
CREATE TABLE IdentType (
    id SERIAL PRIMARY KEY,
    identType character varying(255),                   -- Тип документа, удостоверяющего личность
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS GeoAddress CASCADE;
CREATE TABLE GeoAddress (
    id SERIAL PRIMARY KEY,
    country bigint NOT NULL REFERENCES Country (id),    -- Страна (обязательно)
    region character varying(255),                      -- Область
    district character varying(255),                    -- район
    city character varying(255),                        -- город
    village character varying(255),                     -- село
    street character varying(255),                      -- улица
    house character varying(255),                       -- дом
    apartment character varying(255),                   -- квартира
    zipCode character varying(255),                     -- почтовывй индекс
    locality character varying(255),                    -- населённый пункт, если страна не Казахстан
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS LegalEntityProfile CASCADE;
CREATE TABLE LegalEntityProfile (
    id SERIAL PRIMARY KEY,                              -- PRIMARY KEY
    legalEntityType bigint NOT NULL REFERENCES LegalEntityType (id),    -- Тип юридического лица
    legalEntityName character varying(255) NOT NULL,    -- Название юридического лица (обязательно)
    family character varying(255),                      -- Фамилия
    personName character varying(255),                  -- Имя
    patronymic character varying(255),                  -- Отчество
    IIN numeric(12,0) NOT NULL,                         -- Индивидуальный идентификационный номер (обязательно)
    BIN numeric(12,0),                                  -- Бизнесс Идентифкационный номер
    birthDate date NOT NULL,                            -- Дата рождения (обязательно)
    birthCountry bigint NOT NULL REFERENCES Country (id),   -- Место рождения - страна (обязательно) из списка стран
    citizienship bigint NOT NULL REFERENCES Country (id),   -- Гражданство (обязательно) из списка стран
    taxResidentCountry bigint NOT NULL REFERENCES Country (id),   -- Страна налогового резидкнства (обязательно) из списка стран
    taxNumberForeign character varying(255),            -- Номер налогоплатильщика иностранного государства
    identType bigint NOT NULL REFERENCES IdentType (id),    -- Вид документа, удостоверяющего личность (далее ДУЛ)(обязапельно) из списка документов
    identSerial character varying(31) NOT NULL,         -- Серия ДУЛ (обязательно)
    identNumber character varying(31) NOT NULL,         -- Номер ДУЛ (обязательно)
    identIssueDate date NOT NULL,                       -- Дата выдачи ДУЛ (обязательно)
    identExpDate date NOT NULL,                         -- Дата окончания действия ДУЛ (обязательно)
    identIssuingAuthority bigint NOT NULL REFERENCES IdentAutority (id),   -- Кем выдан ДУЛ (обязательно) из списка организаций
    registrationDoc character varying(255) NOT NULL,    -- Сведения о документе, подтверждающем регистрацию индивидуального предпринимателя (обязательно)
    activityType character varying(255) NOT NULL,       -- Вид предпринимательской деятельности (обязательно)
    license character varying(255),                     -- Сведения о лицензии
    regAddr bigint NOT NULL REFERENCES GeoAddress (id), -- Адрес регистрации (обязательно)
    phyAddr bigint NOT NULL REFERENCES GeoAddress (id), -- Адрес фактический (обязательно)
    migrationCardNumber character varying(255),         -- Номер миграционной карточки (из анкеты ФЛ)
                                                        -- (в случае представления в качестве документа, удостоверяющего личность, заграничного паспорта)
    migrationCardIssueDate date,                        -- Дата выдачи миграционной карточки (из анкеты ФЛ)
    migrationCardExpDate date,                          -- Срок действия миграционной карточки (из анкеты ФЛ)
    foreignPublicPerson boolean NOT NULL,               -- Принадлежность к иностранному публичному должностному лицу (ДА/НЕТ) (обязательно) (из анкеты ФЛ)
    employeeQty integer NOT NULL,                       -- Среднегодовая численность работников (обязательно)
    phoneNumber numeric(20,0) NOT NULL,                 -- Номер контактного телефона (обязательно)
    eMail character varying(255),                       -- Адрес электронной почты (при наличии)
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                      ПРО ПРЕДСТАВИТЕЛЯ                                                                                --
-----------------------------------------------------------------------------------------------------------------------------------------------------------
    repFamily character varying(255),                   -- Фамилия представителя
    repName character varying(255),                     -- Имя
    repPatronymic character varying(255),               -- Отчество
    repPosition character varying(255),                 -- Должность (обязательно)
    repIIN numeric(12,0),                               -- Индивидуальный идентификационный номер (обязательно)
    repBirthDate date,                                  -- Дата рождения (обязательно)
    repBirthCountry bigint REFERENCES Country (id),     -- Место рождения - страна (обязательно) из списка стран
    repCitizienship bigint REFERENCES Country (id),     -- Гражданство (обязательно) из списка стран
    repIdentType bigint REFERENCES IdentType (id),      -- Вид документа, удостоверяющего личность (далее ДУЛ)(обязапельно) из списка документов
    repIdentSerial character varying(31),               -- Серия ДУЛ (обязательно)
    repIdentNumber character varying(31),               -- Номер ДУЛ (обязательно)
    repIdentIssueDate date,                             -- Дата выдачи ДУЛ (обязательно)
    repIdentExpDate date,                               -- Дата окончания действия ДУЛ (обязательно)
    repIdentIssuingAuthority bigint REFERENCES IdentAutority (id), -- Кем выдан ДУЛ (обязательно) из списка опганизаций
    repAddr bigint REFERENCES GeoAddress (id),          -- Адрес представителя
    repPhoneNumber numeric(20,0),                       -- Номер контактного телефона (обязательно)
    repMigrationCardNumber character varying(255),      -- Номер миграционной карточки (из анкеты ФЛ)
                                                        -- (в случае представления в качестве документа, удостоверяющего личность, заграничного паспорта)
    repMigrationCardIssueDate date,                     -- Дата выдачи миграционной карточки (из анкеты ФЛ)
    repMigrationCardExpDate date,                       -- Срок действия миграционной карточки (из анкеты ФЛ)
    repForeignPublicPerson boolean,                     -- Принадлежность к иностранному публичному должностному лицу (ДА/НЕТ) (обязательно) (из анкеты ФЛ)
    powerAttorneyType bigint REFERENCES PowerAttorneyType (id), -- Сведения о документе, на основании которого действует доверенное лицо
                                                        -- (вид документа)(обязательно)(из справочника типов), номер, дата выдачи, срок действия)
    powerAttorneyNumber character varying(255),         -- номер
    powerAttorneyIssueDate date,                        -- дата выдачи
    powerAttorneyExpDate date,                          -- срок действия
-- Сведения о нотариусе, удостоверившим подпись клиента на доверенности, выданной представителю клиента 
-- (ФИО нотариуса, номер лицензии, дата выдачи лицензии, наименование органа, выдавшего лицензию)
    notaryFamily character varying(255),                -- Фамилия нотариуса
    notaryName character varying(255),                  -- Имя нотариуса
    notaryPatronymic character varying(255),            -- Отчество нотариуса
    notaryLicenseNumber character varying(255),         -- Номер лицензии
    notaryLicenseIssueDate date,                        -- Дата выдачи лицензии
    notaryLicenseIssuingAuthority character varying(255),   -- Наименование органа, выдавшего лицензию
--                                  ADDITIONAL INFORMATION                                                          --
    massMedia character varying(255),                   -- Адрес интернет сайта, наличие в СМИ публикаций о деятельности (при наличии)
    offshoreAccount boolean NOT NULL,                   -- Наличие/ отсутствие счетов в банках, зарегистрированных в оффшорной зоне
    sourceFound character varying(255) NOT NULL,        -- Источники происхождения денежных средств
                                                        -- (выручка от реализации товаров/ услуг, продажа недвижимости или иных активов,
                                                        -- гранты от партнеров/ спонсоров, погашение кредиторской задолженности, государственные тендера и т.д.)
    financeStatement character varying(255) NOT NULL,   -- Характеристика финансового состояния
    hasAffilated character varying(255),                -- Наличие аффилированных лиц в системе электронных денег
                                                        -- (при наличии, указать наименование юридического лица или ФИО, ИИН/ БИН)
    transactionCharacter character varying(255) NOT NULL,   -- Предполагаемый характер проводимых операций (сумма операций в неделю, в месяц, в квартал)
    paymenTypeOther character varying(255),             -- Вид платежа (выбрать из выпадающего списка один или несколько вариантов)(для иного)
    subjectOfFinanceMonitoring boolean NOT NULL,        -- Являетесь ли Вы субъектом финансового мониторинга согласно 
                                                        -- пункта 1 статьи 3 Закона о противодействия легализации (отмыванию) доходов,
                                                        -- полученных преступным путем, и финансированию терроризма Республики Казахстан?
    signedContract bytea,                               -- подписаный договор
    isApproved boolean,                                 -- разрешили
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS LegalEntityAndPaymentType;
CREATE TABLE LegalEntityAndPaymentType (                -- связь ипэшника и вида платежа многие к многим
    paymentTypeId bigint REFERENCES PaymentType (id),
    legalEntityId bigint REFERENCES LegalEntityProfile (id),
    updatedAt timestamp DEFAULT current_timestamp,
    PRIMARY KEY (paymentTypeId, legalEntityId)
);

DROP TABLE IF EXISTS Customer CASCADE;
CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    phoneNumber numeric(20),                            -- Номер телефона пользователя
    passwordHash character varying(255),                -- Хэш пароля
    updatedAt timestamp DEFAULT current_timestamp
);

DROP TABLE IF EXISTS CustomerAndLegalEntityProfile;
CREATE TABLE CustomerAndLegalEntityProfile (
    customer bigint REFERENCES Customer (id),
    legalEntityProfile bigint REFERENCES LegalEntityProfile (id),
    updatedAt timestamp DEFAULT current_timestamp,
    PRIMARY KEY (customer, legalEntityProfile)
);

INSERT INTO Country (country) VALUES 
    ('Абхазия'),
    ('Австралия'),
    ('Австрия'),
    ('Азербайджан'),
    ('Албания'),
    ('Алжир'),
    ('Ангола'),
    ('Андорра'),
    ('Антигуа и Барбуда'),
    ('Аргентина'),
    ('Армения'),
    ('Афганистан'),
    ('Багамские Острова'),
    ('Бангладеш'),
    ('Барбадос'),
    ('Бахрейн'),
    ('Белиз'),
    ('Белоруссия'),
    ('Бельгия'),
    ('Бенин'),
    ('Болгария'),
    ('Боливия'),
    ('Босния'),
    ('Ботсвана'),
    ('Бразилия'),
    ('Бруней'),
    ('Буркина-Фасо'),
    ('Бурунди'),
    ('Бутан'),
    ('Вануату'),
    ('Ватикан'),
    ('Великобритания'),
    ('Венгрия'),
    ('Венесуэла'),
    ('Восточный Тимор'),
    ('Вьетнам'),
    ('Габон'),
    ('Гаити'),
    ('Гайана'),
    ('Гамбия'),
    ('Гана'),
    ('Гватемала'),
    ('Гвинея'),
    ('Гвинея-Бисау'),
    ('Германия'),
    ('Гондурас'),
    ('Государство Палестина'),
    ('Гренада'),
    ('Греция'),
    ('Грузия'),
    ('Дания'),
    ('Джибути'),
    ('Доминика'),
    ('Доминиканская Республика'),
    ('ДР Конго'),
    ('Египет'),
    ('Замбия'),
    ('Зимбабве'),
    ('Израиль'),
    ('Индия'),
    ('Индонезия'),
    ('Иордания'),
    ('Ирак'),
    ('Иран'),
    ('Ирландия'),
    ('Исландия'),
    ('Испания'),
    ('Италия'),
    ('Йемен'),
    ('Кабо-Верде'),
    ('Казахстан'),
    ('Камбоджа'),
    ('Камерун'),
    ('Канада'),
    ('Катар'),
    ('Кения'),
    ('Кипр'),
    ('Киргизия'),
    ('Кирибати'),
    ('Китай'),
    ('КНДР'),
    ('Колумбия'),
    ('Коморские Острова'),
    ('Коста-Рика'),
    ('Кот-д''Ивуар'),
    ('Куба'),
    ('Кувейт'),
    ('Лаос'),
    ('Латвия'),
    ('Лесото'),
    ('Либерия'),
    ('Ливан'),
    ('Ливия'),
    ('Литва'),
    ('Лихтенштейн'),
    ('Люксембург'),
    ('Маврикий'),
    ('Мавритания'),
    ('Мадагаскар'),
    ('Малави'),
    ('Малайзия'),
    ('Мали'),
    ('Мальдивские Острова'),
    ('Мальта'),
    ('Марокко'),
    ('Маршалловы Острова'),
    ('Мексика'),
    ('Мозамбик'),
    ('Молдавия'),
    ('Монако'),
    ('Монголия'),
    ('Мьянма'),
    ('Намибия'),
    ('Науру'),
    ('Непал'),
    ('Нигер'),
    ('Нигерия'),
    ('Нидерланды'),
    ('Никарагуа'),
    ('Новая Зеландия'),
    ('Норвегия'),
    ('ОАЭ'),
    ('Оман'),
    ('Пакистан'),
    ('Палау'),
    ('Панама'),
    ('Папуа - Новая Гвинея'),
    ('Парагвай'),
    ('Перу'),
    ('Польша'),
    ('Португалия'),
    ('Республика Конго'),
    ('Республика Корея'),
    ('Россия'),
    ('Руанда'),
    ('Румыния'),
    ('Сальвадор'),
    ('Самоа'),
    ('Сан-Марино'),
    ('Сан-Томе и Принсипи'),
    ('Саудовская Аравия'),
    ('Северная Македония'),
    ('Сейшельские Острова'),
    ('Сенегал'),
    ('Сент-Винсент и Гренадины'),
    ('Сент-Китс и Невис'),
    ('Сент-Люсия'),
    ('Сербия'),
    ('Сингапур'),
    ('Сирия'),
    ('Словакия'),
    ('Словения'),
    ('Соломоновы Острова'),
    ('Сомали'),
    ('Судан'),
    ('Суринам'),
    ('США'),
    ('Сьерра-Леоне'),
    ('Таджикистан'),
    ('Таиланд'),
    ('Танзания'),
    ('Того'),
    ('Тонга'),
    ('Тринидад и Тобаго'),
    ('Тувалу'),
    ('Тунис'),
    ('Туркмения'),
    ('Турция'),
    ('Уганда'),
    ('Узбекистан'),
    ('Украина'),
    ('Уругвай'),
    ('Федеративные Штаты Микронезии'),
    ('Фиджи'),
    ('Филиппины'),
    ('Финляндия'),
    ('Франция'),
    ('Хорватия'),
    ('ЦАР'),
    ('Чад'),
    ('Черногория'),
    ('Чехия'),
    ('Чили'),
    ('Швейцария'),
    ('Швеция'),
    ('Шри-Ланка'),
    ('Эквадор'),
    ('Экваториальная Гвинея'),
    ('Эритрея'),
    ('Эсватини'),
    ('Эстония'),
    ('Эфиопия'),
    ('ЮАР'),
    ('Южная Осетия'),
    ('Южный Судан'),
    ('Ямайка'),
    ('Япония');

INSERT INTO LegalEntityType (legalEntityType) VALUES
    ('ИП');

INSERT INTO IdentType (identType) VALUES
    ('Удостоверение личности гражданина РК'),
    ('Паспорт гражданина РК'),
    ('Вид на жительство иностранного гражданина'),
    ('Паспорт иностранного гражданина');

INSERT INTO IdentAutority (identAutority) VALUES
    ('МВД РК'),
    ('МЮ РК');

INSERT INTO PowerAttorneyType (powerAttorneyType) VALUES
    ('Доверенность');

INSERT INTO PaymentType (paymentType) VALUES
    ('оплата услуг операторов сотовой связи'),
    ('оплата коммунальных услуг'),			
    ('оплата кабельного телевидения'),
    ('оплата товаров'),
    ('оплата услуг'),					
    ('оплата услуг Акционерного общества «Казахтелеком»'),
    ('переводы с одного банковского счета клиента на другой банковский счет'),
    ('таможенные платежи'),
    ('пополнение банковского счета путем взноса наличных денег'),
    ('налоговые платежи'),
    ('погашение займов'),
    ('страхование'),
    ('размещение вкладов, по которым начисляется вознаграждение'),
    ('снятие вкладов, по которым начисляется вознаграждение'),
    ('иные виды платежей и переводов денег'),
    ('оплата медицинских услуг');