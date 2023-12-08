
Drop Table if exists [Dept].[ModeOfInstruction]
Create Table [Dept].[ModeOfInstruction](
	ModeId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	[Mode Of Instruction] [Udt].[InsMode] NOT NULL, 
	CONSTRAINT CHK_ModeOfInstruction CHECK (LEN([Mode Of Instruction])<=50)
)

