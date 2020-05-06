/* =================================================================================================
 FUNKCJ(Scalar-valued); Function that converts data for the needs of quick export and import
                        @mode=1 - Replacing selected special characters with variables {{NR_ASCI}}
                        @mode=2 - Replace the selected variables {{NR_ASCI}} with special characters
  ================================================================================================== */
  ALTER FUNCTION [dbo].[fuDetectAndReplace] (@mode INT=1,@werString VARCHAR(MAX))
  RETURNS VARCHAR(MAX) AS BEGIN

     DECLARE @s VARCHAR(MAX)
     DECLARE @len INT

     SET @len= len(@werString)

     IF @mode=1 AND @len>0
     BEGIN
        DECLARE @position int
              , @aux   char(6)
              , @newS  char(6)

        SET @s = ''
        SET @position = 1

        WHILE @position <= DATALENGTH(@werString)
        BEGIN
            SET @aux = ASCII(SUBSTRING(@werString, @position, 1))

                            SET @newS = ''
            IF @aux='7'     SET @newS='{{07}}'
            IF @aux='10'    SET @newS='{{10}}'
            IF @aux='13'    SET @newS='{{13}}'
            IF @aux='39'    SET @newS='{{39}}'
            IF @aux='32'    SET @newS='{{32}}'
            IF Len(@newS)=0 SET @newS = CHAR(@aux)

            SET @s = @s + replace(@newS,' ','')

            SET @position = @position + 1
        End

        SET @s=REPLACE(@s,'{{32}}',' ')
     End

     IF @mode=2 AND @len>0
     BEGIN
         SET @s = @werString
         SET @s = REPLACE(@s,'{{CHR7}}',char(7))
         SET @s = REPLACE(@s,'{{CHR10}}',char(10))
         SET @s = REPLACE(@s,'{{CHR13}}',char(13))
         SET @s = REPLACE(@s,'{{CHR39}}',char(39))

         SET @s = REPLACE(@s,'{{07}}',char(7))
         SET @s = REPLACE(@s,'{{10}}',char(10))
         SET @s = REPLACE(@s,'{{13}}',char(13))
         SET @s = REPLACE(@s,'{{39}}',char(39))
     End

     RETURN @S
  End 
GO