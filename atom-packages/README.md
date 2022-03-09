# Wizard's Atom package

This was my poor attempt of making a package for Atom, but it was useful

## What it does
Using `ctrl+p` generates a print line statement for the respective langauge:

### Java
#### If no text is selected:
```java
System.out.println("");
```
Where the cursor will be left inside of the `""`.
#### If text is selected:
```java
System.out.println("selectedText = " + selectedText);
```
#### Example:
```java
int x = 42;
System.out.println("x = " + x);
```

### Python
#### If no text is selected:
```py
print("")
```
Where the cursor will be left inside of the `""`.
#### If text is selected:
```py
print("selected_text = " + str(selected_text))
```
#### Example:
```py
x = 42
print("x = " + str(x))
```

### C
#### If no text is selected:
```c
printf("%s\n", );
```
Where the cursor will be left after the comma `,`.
#### If text is selected:
```c
printf("selected_text = %s\n", selected_text);
```
#### Example:
```c
int x = 42;
printf("x = %s\n", x);
```
Note that the `%s` is a default and should be updated manually according to the variable, for instance, it should be `%d` in this example.


## Installation
Put the `wizard` directory inside your `.atom/packages` directory (in your home directory, it will be hidden so use `ctrl+h` to reveal it)