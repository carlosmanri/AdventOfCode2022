package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"unicode"
)

func main() {
	rucksacks, _ := readLines("input.txt")

	var commonItems []rune
	for _, rucksack := range rucksacks {
		commonItems = append(commonItems, getItemsInBothCompartments(rucksack)...)
	}

	fmt.Println("Sum of all priorities", sumPriorities(toPriorities(commonItems)))
}

func sumPriorities(priorities []int) int {
	arrSum := 0
	for i := 0; i < len(priorities); i++ {
		arrSum = arrSum + priorities[i]
	}
	return arrSum
}

func toPriorities(items []rune) []int {
	var res []int
	for _, item := range items {
		if unicode.IsLower(item) {
			res = append(res, int(item)-96)
		} else {
			res = append(res, int(item)-38)
		}
	}
	return res
}

func getItemsInBothCompartments(rucksack string) []rune {
	firstCompartment := rucksack[:len(rucksack)/2]
	secondCompartment := rucksack[len(rucksack)/2:]

	if !strings.ContainsAny(firstCompartment, secondCompartment) {
		return nil
	}

	commonItems := ""
	for _, item := range firstCompartment {
		if strings.Contains(secondCompartment, string(item)) && !strings.Contains(commonItems, string(item)) {
			commonItems = commonItems + string(item)
		}
	}
	return []rune(commonItems)
}

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}
